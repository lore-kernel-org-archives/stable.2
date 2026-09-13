Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D1390618
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 04:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789273122; cv=none; b=klO4HuZOJXrV26yBzXgTIAQ998JdToY3o5bfmfUCjbAI1roinpciAHBEEkygi2qzfZgQnNerB7L5CQ4Ffygsc+btu8qOemN1crTjokOajIoQZijiszuri+EmTVOrRXMQgx2yyg8s4pwA7HvuVmQWCGiC8X9eKIVvd4XmXzpqDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789273122; c=relaxed/simple;
	bh=KIIwlgtQiPCeDblTe7idpuN5xdTWR3wTnKQTNX2q9PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzi9J75erqUrsOxrW4qNDTCo0EMxqrDjcvzwgqKYSLE+tNR4hk6rQGnWgsuwymSLAqf1LuNvzhZD/nTwTvbqeIIbNs0wzKUZiugnikrjnbrklYJwlbTCcPjWm1rbZb2R4ptYpIjDKqd8uql3QWncqRsZ18LISsc8Zr52j8EiyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwioAeQQ; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwioAeQQ"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcb5cb1so14392786d6.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789273117; x=1789877917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Cy9tKh8kDj+/dr3iT8f18N8p4TbAne3xHKS21+yoCc=;
        b=YwioAeQQdmz/TxQSxi3uouTkYpJYa31T8UqFnDBkXw04ZCyYq77bUMGli12nOrSfpk
         XnWyuvFJcyBqK6cqeVfyxRIQxQ7Sz2wWxmXoooYMkoeNkehQzyIohjFm9joo8UAJ5vre
         7BaM04DGeNzaWAcKjcKojSKGKHkEzaoJc2VzndRJWGCKRBer6y2xww75HGe3fJMS/eY2
         iw/DqfqMzsMr0KuTK9TcmF/fmHguMsP1ejXidZzO8y1YmLbtPJCYBdAEVMm7FIkzGriK
         0qzDvwG91BK6qKACPYn+x6rWABFNIIr22vhRk2lCnc6s0Um9hzJE8GABOnJVS48yp5BE
         bs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789273117; x=1789877917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Cy9tKh8kDj+/dr3iT8f18N8p4TbAne3xHKS21+yoCc=;
        b=GezFrJejMcjYR7ymrcLoxgKN+5SP6nZDEYL/fzW+u2EZ00hBDG4PTgCZ+5fSC9UA1/
         uAfYjNhnzRrtHI2K64PvMSMJ3snVjthp4MW/TbWvgQLkuX8IlllHaQ8K01cQerMdmw+V
         Lxsh/GillsrPrnQQW7uZOFPkglnnDBbebJrb+/ZWtmqsT/L69NAGsx+YwrqT1i/feAVa
         yAS+AojD6xOvEorIwlMBRgFspkCP/rd1tAsF8eNXgg2i3C5JrOH85s8smddwqvmF7Lq/
         u5uK//SaKPJodry5PqFTclN3UCimlKeF66Xz/cTFxdBKGhWevJ7dIG9NdYksS4/c0GUA
         jdMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTFA5NykpvagHMJiMTZYkpHEGDfEPOPB3uteFSgk1IdiIRgQaTBZA4bvQtKJ7oKQ/OyOmHgOs=@vger.kernel.org
X-Gm-Message-State: AFuF++mNs3HhulGf3+MkZkpobBdeR1qcCkUXNliShAPQCrsY9cd5L6M/
	3/4ti83nFFGn+e21qsA7cnFt7D/ZYxJiOgzDUe2tt+btff4lk9CQR58=
X-Gm-Gg: AYBFou1dpdhKdNUc6T01oQ1dELNfqPDfngz4Fe4DNh2avJogod7eP7bp38GQAMuqFkr
	fdBsPywPDA9ajcLGdQOWfJDrjUsj4wvBj3dA+PBlnqeYn1s1+dgMTgbqDy965svdjnuLDG4rVlo
	ZuXyCKU+Y1/VGWINwIr/dBmRlqOF2ydsV4/P+3csPqwrCKC2a7H+zawLAKMsCXOqqP0dCJqiV0f
	ShBg1OIVi0Dnpt6rXKPWzpnJs/FAXbPhZKdf3mPp3o6AWIGxPnSGNLhbztrwXK1ylgFg2mgXJDc
	s6QndWHWJrDDEY++9uZXfjWudSQ1RnMRVqrr/++icQHmNb6sRa4minA/3ddBILp/tJ7vHLgAP4Q
	HrOc+Pqk54PnIo/KOp0SlTtAfWfyym4Dm+iIfNvFNo+IguxEd6Sj/siJKkcO+6hP5E65WjlVcW8
	4MdjSEvLaxCi7gR2IzEtwb8FDlRwErzhpKCgyaZjcz+OhRGxso7TiOar2Y5etvWW3ZkM1XysbEI
	2oCaUBmhHFgbtrN8C6bYxUc+4errrKEr/KQked+RNI78jM6VViOavx7ao6zWN0A/ly7NzDdkM/o
	cO3Ksaegk78uyXMx2ycLc68x5Xxmp6J0mw==
X-Received: by 2002:a05:6214:20ef:b0:910:74ec:8892 with SMTP id 6a1803df08f44-9121d8eb88amr91874446d6.6.1789273117604;
        Sat, 12 Sep 2026 21:18:37 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45adbfsm61735926d6.13.2026.09.12.21.18.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 21:18:36 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Daniel Scally <dan.scally@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] media: i2c: dw9719: power down on detection errors
Date: Sun, 13 Sep 2026 00:18:28 -0400
Message-ID: <20260913041828.28430-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving chip detection into dw9719_power_up() introduced direct returns
after the regulator has been enabled. An INFO register read failure or an
unrecognized ID bypasses the power-down path, while probe only cleans up
the media entity and controls after a power-up error.

Route both detection errors through the existing power-down check. Preserve
the read error or -ENXIO and leave the successful power-up and regulator
enable failure paths unchanged.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 2a1551665a85 ("media: dw9719: Add DW9761 support")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/i2c/dw9719.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/dw9719.c b/drivers/media/i2c/dw9719.c
index 3b7ba88fd..8a34abe18 100644
--- a/drivers/media/i2c/dw9719.c
+++ b/drivers/media/i2c/dw9719.c
@@ -150,7 +150,7 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 
 		ret = cci_read(dw9719->regmap, DW9719_INFO, &val, NULL);
 		if (ret < 0)
-			return ret;
+			goto out;
 
 		switch (val) {
 		case DW9719_ID:
@@ -168,7 +168,8 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 		default:
 			dev_err(dw9719->dev,
 				"Error unknown device id 0x%02llx\n", val);
-			return -ENXIO;
+			ret = -ENXIO;
+			goto out;
 		}
 
 props:
@@ -218,6 +219,7 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 		cci_write(dw9719->regmap, DW9719_VCM_FREQ, dw9719->vcm_freq, &ret);
 	}
 
+out:
 	if (ret)
 		dw9719_power_down(dw9719);
 
