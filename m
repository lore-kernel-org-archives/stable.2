Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C430DEB0;
	Tue, 11 Aug 2026 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416842; cv=none; b=L+/ECqxPN1eJsqTlzsJYLcZVfDFl1rw+PmVcf9SnCJwAzizK3oSjDq9acDHihKdMgpJSDAs3/p6oC+tWXUawS4q/q5WQLg449VdANL3CSJ47XJz8vi7GNmbVO4A1VJqiG2czMgZp+VWH6YQxwZnbA4XGjeTE5pEA/vsjy7tJZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416842; c=relaxed/simple;
	bh=hJ44q0vZWvA19BzpbGNRhablWhjKkhsmI326dingyEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6JGqn0ALiv2V+XP3tw6ZuPd45C661fzQhrMrD/ga8Ynghk71kllUwZVzSsII1/Oc39WDgpHP0eQmglI2DeVdVFL8omZKQ+r9hYSM1dDyoC3ElQnEMjIOTjhW9duqfYJZYWhjKe/lXayLMBUgrpzAlTPcdTUozf4AEgj83lM3s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dqdbgNIH; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dqdbgNIH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=06
	THnmpNNrOJ+53E1j8ULKWSVKIqa8vKQb/BIHPSbys=; b=dqdbgNIH94wdqtq19O
	sX5S9PXoObIFjmFUXkDDdgAqFkLliLK3KUsbqrrHF16h2IklTuGrF3dQA43TOqrc
	J0XbwWmW10XxWrTsq8YLSqhM2ncS9DzUxjH1JeV96bvEWIWHbCJDYXXg0lRfTvz6
	j90X9KiI5g86+8fwRiv2ZmSrU=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBHmSqfjnpqAmfvAw--.36476S2;
	Tue, 11 Aug 2026 10:53:19 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: jic23@kernel.org,
	andy@kernel.org,
	joshua.crofts1@gmail.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH v2] iio: pressure: bmp280: fix out-of-bounds access in sampling frequency lookup
Date: Tue, 11 Aug 2026 10:52:53 +0800
Message-ID: <20260811025252.1187644-2-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805074127.473731-1-sh_def@163.com>
References: <20260805074127.473731-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHmSqfjnpqAmfvAw--.36476S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWkWryrAFy8AF1xCw1DAwb_yoW8WF18pr
	WkKF1akrW8Gw1ku3WkAanrWFWruwn3Jr4fWFW7C3y8uw43ZFyjqryj9rWFyrWYyrs8CFsI
	yrsF9ryDKrn8XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piH7KxUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQEFZGp6jqE78QAA3U

The sampling frequency tables store each frequency as an integer part and
a fractional part in micro units. num_sampling_freq_avail is initialized
to the number of flattened integer elements because read_avail() returns
the table as a flat array.

bmp280_write_sampling_frequency(), however, indexes the same table as a
two-dimensional array and uses num_sampling_freq_avail as the number of
rows. Convert the flattened element count back to the number of rows
before iterating over the table.

Fixes: 10b40ffba2f9 ("iio: pressure: bmp280: Add more tunable config parameters for BMP380")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
- Use plain 2 as the divisor, as suggested by Andy Shevchenko.
- Add Joshua Crofts' Reviewed-by tag.
Link: https://lore.kernel.org/lkml/20260805074127.473731-1-sh_def@163.com/

 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 990340a9b10c..dbe42233c81d 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -836,7 +836,7 @@ static int bmp280_write_sampling_frequency(struct bmp280_data *data,
 					   int val, int val2)
 {
 	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
-	const int n = data->chip_info->num_sampling_freq_avail;
+	const int n = data->chip_info->num_sampling_freq_avail / 2;
 	int ret, prev;
 	int i;
 
-- 
2.43.0

