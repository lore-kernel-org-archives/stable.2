Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C63537CD
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783968246; cv=none; b=hPABMZfGx0gImSnq5oIr6iK98wAkpjJzAAILPhU8d8EdAgva/9zZFy82mkrU9PKMV/UJcF6XlaXiwf424elt0VwsyJhqAgOq2Bfy5HHTFm+mJD7H4BGRlV6Vm+QbNKNW1Ezr3G5amElluo5rIl1j3IObOhTDVAMJ/fGjhm34tdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783968246; c=relaxed/simple;
	bh=BD7RgtT7LVUzyH5B2yO7qKo7Aoo/3KiO9wN/6gozsds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3pYlgdEXhZ05D2Q96ik8n/478tiEaTPDDhMo6NXupUuJRcO9GDxrDpL10/7wYTjDWvKjDaHdvnzU6/uaa0jTGb/ksik4QZU68O2xihGV9BeYa3pvC6T9dJX3bBXqwUgdE3xvw5P+kcoU5F9ANPyhB90HLznzplcPh3ISbv9tds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+lwgKg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+lwgKg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4011F000E9;
	Mon, 13 Jul 2026 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783968245;
	bh=tFdcY9/unnw9ZqBEebLvoO7DAa0kXmsT+Ii4u6E1bDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+lwgKg8MZP4R9vTzZWH/IdRSLQY26DJv9PUNaQbWiPvC7AwAtJ5rmlC7nSrGSpAp
	 OwRYqyG+U4/gwoXV+OKGTbigk/26Je5MZfyZ84/gpzjE4RElFy5DI94EIP8lfyROg4
	 OeBmxXTqakPhgNi6URmDaW/BdUkLLyg45NupFjh6Stu26Am4GdYu55KTv/YDnh6ECF
	 gDdMjKmtm0P/epOoNfHAGAmH/J2w4iXyoCWGUZBuTnHnuOZu6WzVmw0mCEpBG0tpxI
	 13nnUsyIegQYkSYi73BfEeGwyYQJxG28q6Tmn9aAyOqdgy3u5Nxzppa5M/D/EiGTST
	 MBRWpa5Wcrt9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] iio: pressure: mpl115: fix runtime PM leak on read error
Date: Mon, 13 Jul 2026 14:44:03 -0400
Message-ID: <20260713184403.1954310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071341-matchbox-decay-e5c8@gregkh>
References: <2026071341-matchbox-decay-e5c8@gregkh>
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
index 830a5065c008f8..16e112b796ba9e 100644
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

