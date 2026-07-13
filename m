Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9A357CE9
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971432; cv=none; b=uI+D0rZU4bqtN+Ee6VxJHRiTK0qXgagelXF5a85af3jXkopA4CplVZxSTnmd5AYs8goYiOZukZDK8pGIl+Opd/EyUWn8JBmzaDrUuNmaVqGqobpXqgfYWrU+o9X4Y1Z9doge9jOOGE93Xq/tjFjmFeApvNkpjwAxMN00qEQd6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971432; c=relaxed/simple;
	bh=MJq1fm2luXJMkmYln+5H20kq8NZO8TMdz0aFrJd223g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqnpfK2nBacJy3zJmeqUOdPnViLvcAcqE5eHZnTFx8hyUXkatcEM5fjmu2fm0xj/1c9d8XqOhDh0EvzRrcCZcs7VVn++FwgD14ObJS8J1hdqHYrgm19p97LtaOuyXC8gVfoq2h+6iHOtkxkHQe0VnVGrLY6Tp4NvPIkYP8E19Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/djOljZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/djOljZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F131C1F00ADF;
	Mon, 13 Jul 2026 19:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971431;
	bh=502MmbbA0DROJE9Ngx7Tv7g9FElr0jhMz0k7+z3BM5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/djOljZmXROoAetJOOqqlRztciqOI1ICzlMbDMXv6Vk8OaFiPsFgnN7EIWT+sDf2
	 6PQ/2kBulet9lnWRGmLG1tcYIH8turE9A2K6DRXiF/PapiZ2/PMetCXHLj2n3AypAj
	 BeBfkH+Nnk51WQ3K6EYcKRPHadEF7G6va6ID0seC/ohw2iee+4RAE6SEWJFvNI+jgV
	 yZWrOs3x6EMSAMX7gNj4PW5VL994lT9rdL+66zg6x+26zdGRnxJw0ancLO5ywpnL4b
	 r2nPUuYAQGMbbBIPFu/OsYnmw33Rki20IcAVUHZyHIk2R1CFjt7lrkr+YyfAX2hc4C
	 DHoFcOYczvbyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iio: pressure: mpl115: fix runtime PM leak on read error
Date: Mon, 13 Jul 2026 15:37:08 -0400
Message-ID: <20260713193708.2054715-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713193708.2054715-1-sashal@kernel.org>
References: <2026071315-trespass-legible-97d4@gregkh>
 <20260713193708.2054715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biren Pandya <birenpandya@gmail.com>

[ Upstream commit fbe67ff37a6fd855a6c097f84f3738bd13d0a898 ]

mpl115_read_raw() takes a runtime PM reference with pm_runtime_get_sync()
before reading the processed pressure or raw temperature, but on the read
error path it returns without calling pm_runtime_put_autosuspend(). Each
failed read therefore leaks a runtime PM reference and prevents the device
from autosuspending.

Drop the reference before checking the return value so both the success
and error paths are balanced.

Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Assisted-by: Claude:claude-opus-4-8 coccinelle
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/mpl115.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 18c2488e182cdc..11ee879f4da440 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -106,18 +106,18 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 		*val = ret >> 6;
 
 		return IIO_VAL_INT;
-- 
2.53.0

