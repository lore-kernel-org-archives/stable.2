Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF63E49D0;
	Wed,  5 Aug 2026 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915850; cv=none; b=k6pGb7a9xhiLCYTKFxEZSuI5eKje8vwjp6mS1Ucr4+/oSyTSAMqw088P+/tOJNgFuIb41paNC7vS+dkIDv2iJG49XR6ul9xZFdbbmYvqy3S0yel0Tp62VRtdXj7Lu9clDYrBUEx6ll9nV9Rm6d9DMbY4Z/IMYSooxDbf44GYm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915850; c=relaxed/simple;
	bh=hp2i/PGGCMpitbNxZUAlST9uv0iy4lEOi7R1hfvfIuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2KuinrgfxE7oFDBbZ3vSdr3YlgonpVman8kNmC/iWijqD6r/HRyo5vEJCsi0cYN1O0LH8YW2fpDocJzhIoozRQ1ZJvb4iIjlWewK7ja9eydrqm65fOwyhYozzxcK0waP8sWa1+ctFuPUwLdIzq3RUZS33TWUw1c6BnDYPPmftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c641dUj2; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c641dUj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=wV
	XeVZTf2M/GXSigAGCsBdLBqsm+xeB/8ix1nyvkrxg=; b=c641dUj2Q2losA3zG4
	xumYcDb1PaPsCbDQ8zC2EOBPQmT1myigHzHtEH8TxdqfT9u1ude9TEOljasSnpOL
	C/yOew+MCqNXZLwL0wl5F/SmRaNL7qJX+gDQEAnMVRhG7Kf8QsMLXy3zZPfy5kuS
	LHO7M8mfuW2MvEsDojeP6QBcg=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3HxSl6XJqtf2bJw--.20463S2;
	Wed, 05 Aug 2026 15:43:34 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: pressure: bmp280: fix out-of-bounds access in sampling frequency lookup
Date: Wed,  5 Aug 2026 15:41:27 +0800
Message-ID: <20260805074127.473731-1-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3HxSl6XJqtf2bJw--.20463S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWkWryrAFy8AF1xCFWDXFb_yoW8Xrykpr
	Z7KFyakrW5Gr1kZw1kJa1DGFyrZwnrJrWSgry7Cw48Aw43ZFyDXryj9ryrArWYyrsxJFsF
	yrsF9FWDGrs8XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEv38UUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQbaOmpy6abt-QAA3g

The sampling frequency tables store each frequency as an integer part
and a fractional part in micro units. num_sampling_freq_avail is
initialized to the number of flattened integer elements because
read_avail() returns the table as a flat array.

bmp280_write_sampling_frequency(), however, indexes the same table as a
two-dimensional array and uses num_sampling_freq_avail as the number of
rows. This makes the lookup walk past the end of the table when an
unsupported sampling frequency is written.

Convert the flattened element count back to the number of rows before
iterating over the table.

Fixes: 10b40ffba2f9 ("iio: pressure: bmp280: Add more tunable config parameters for BMP380")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
 drivers/iio/pressure/bmp280-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 990340a9b10c..ddd2de3c35ba 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -836,7 +836,8 @@ static int bmp280_write_sampling_frequency(struct bmp280_data *data,
 					   int val, int val2)
 {
 	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
-	const int n = data->chip_info->num_sampling_freq_avail;
+	const int n = data->chip_info->num_sampling_freq_avail /
+		      ARRAY_SIZE(*avail);
 	int ret, prev;
 	int i;
 
-- 
2.43.0

