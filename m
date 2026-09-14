Received: from mail-pz2-f18.google.com (mail-pz2-f18.google.com [74.125.228.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4F3CB56B
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426394; cv=none; b=WFHW/0dzGDQFwDW6k3MQknsRFE6QBL9Vf56OGJgxzOq+QY0xlJaGHDMu5TOij7iY43UPLf/utbzOcrUzaPMjrLo3X+lXzxkWcXFGrZ3lr3JwE6UUL9u49p5SreWfVXbqdogbSQSMQ64Dw5HWpb2FwEHfRGSC05jVcEbZ1h4mdKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426394; c=relaxed/simple;
	bh=BiHA2LT7VXF4lmqoIJBRziOH8CBF0C2zrU9LI3lG4Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLEW9zF6/8fEnxFUChOHZGehkh4nwFR8HNbUdbEFmS+trjVwC1jR7+Ia2FcH1MdBdlqRh/y9pUkIGihVucgdmI8lV+zQdB/NM5qkIRJKImfzNj1zqHg5yJlYEMAnruIczNq8gEjTIQ4eDBY0kJa8th4uaeTCsj9TlcJ3cS1JsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du2cWIiF; arc=none smtp.client-ip=74.125.228.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du2cWIiF"
Received: by mail-pz2-f18.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso2520333a12.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426392; x=1790031192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1HiEFknvKCDeWKiMrML1PicHIEUqaWiAMUs85FKMew=;
        b=Du2cWIiFsr4HicHADRWDlAtd9D8PjVL9lUtzdW28DrgZabvAPYG42IodBGVI82I7YD
         9exlAMfIm1Smf0GskSm13WkEAb5Ztn+2VcexeQJTeD3xbz2yAYjSuPseX6xW2hSMsXLe
         qONYSKEtvH7ZONJjPtq89+lyKhI3bGfddD+Bb4UQncz/+TlmlApvo9S5pTAuGHXsrVwJ
         mUSK71amq4K+lxI5C3kep+BQmBzow8h3HeaXQH5o6KwzWO8snT7z7bkbxCha2YmZcP8v
         MMo9+2A2fevRuxr6dI24aNTwQSdvHsSZTZBqTQo7TVM+X9EicScmv+LdmCBaWmOFjsLW
         S2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426392; x=1790031192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1HiEFknvKCDeWKiMrML1PicHIEUqaWiAMUs85FKMew=;
        b=ndh/KOkSSnKuXaIOTG+tiBLU+aN7hkVdN8L4Fj/1pwKBWzsvHEXxDqCPphkSn/rYdc
         Egw3yNgZtx1NlUsv392ryHnqaStsYrN7FSl82kCiQ7VziMWJGqEITZ/rLR/0VURpFXvd
         bLo2zp3Wra5/TDjcnWvBieajwX6R7QkULJGNmu3Ep917Tnh/7/S/rjReH9xu+1nb7xqU
         twi4nAp5CHgWc2kXHT6l217fOlWBBSzw6CnlRQ6k7Ed5HsSn6NMFS2+jT2lV0G+wi3Nf
         fXrDRImveiKmbhUn/AuQlyhzahHlInVWnXxgFK7TCnNOJhjYJAFjIWu49gP8qVIrUWeq
         LI2A==
X-Forwarded-Encrypted: i=1; AKwUvByW5/WdcEUddUAE3xdOU1iMRpZCT2PVMI8BbD/N5n4zJCphkuzCY5QjTIaALWNG8O1V8xPEcqg=@vger.kernel.org
X-Gm-Message-State: AFuF++liaqJi7hrsxL6OOWzcTM2vJezxH3wuoOS5maEOUX3RbEKJW4lT
	Jq54o8AErnP79vuRsrs7nZcj7Xt0h+Ru5dLG/ZCSX/ML9AIj7RzxOKD9
X-Gm-Gg: AYBFou0mF2/pTEHtHNJphdsQa+Lf6V3OwkJEJ7/o0Vd72wtHjHB0ICOcjavPiaAacHa
	6olKFGHSCyu5BK79GEXID4c0d+ScFTNrx9L9E+vCmluSeXtZ7/AwwxMoRr312k3LRyPb0HCkHpm
	p6EgpZhrg5ZOjnpcyITEKzLyMV/SVwc0ZTTNp7CqhCqytzVo+X9B8M88qh1/PRK5pvvvI9K2ntC
	1JMsgvLB8JwdolX1YoRzCjbgCc539OgoEo1DGpemNCLIBms0gdHmeLUgP9jYj2oXbPlnahCm3NN
	j49ANBC3whjfk8cpRPYq+koIICTbRo7msXngia9EkIQ3MufNBEETLD8+k43A/H/6jbjazx2EpE1
	yW19Bg9Pz50eUjOYRBLcYEDJoc/gAB8G2xANCSS4BYhNg6SKgxk8GyZgbj8q29vUeA4cQU9aK9e
	9DdQdeKDn1Yl9VBRpd+nk84KRtSQ6VnVPK9G+97mWD6ZE4fFYNmaxfhNfsuzbP3Qgg46YdBCiQb
	PFpD+p4FpOzqW231JlB75uYWvkYvbUgtWJSRjbg7y6FC1HEr0Os
X-Received: by 2002:a05:6a21:b94:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3db405220aemr10555230637.17.1789426392490;
        Mon, 14 Sep 2026 15:53:12 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:11 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 04/10] HID: hid-lenovo-go-s: Use pm_ptr for reset_resume callback
Date: Mon, 14 Sep 2026 15:52:57 -0700
Message-ID: <20260914225303.868569-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914225303.868569-1-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds missing pm_ptr to the .reset_resume callback for hid-lenovo-go-s

Fixes: 3524900cc571bd922a ("HID: hid-lenovo-go-s: restore OS_TYPE after resume from s2idle")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 8b16fc7d151e..b6850cf2c029 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1556,7 +1556,7 @@ static struct hid_driver hid_lenovo_go_s = {
 	.probe = hid_gos_probe,
 	.remove = hid_gos_remove,
 	.raw_event = hid_gos_raw_event,
-	.reset_resume = hid_gos_reset_resume,
+	.reset_resume = pm_ptr(hid_gos_reset_resume),
 };
 module_hid_driver(hid_lenovo_go_s);
 
-- 
2.55.0

