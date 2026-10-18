Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4549AA4B
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359497; cv=none; b=u53PHRiE7RMlMaayYnTJmdWt5RpvF62PYABKaWWn0CBJvCXylyYCwQcBi71yEw1bfzBcs2vua3tqDpd7Qo6SDlMap0vtR3Jrh4w515lfw7tbVwRuJFNPyMVjokho4UKebcJUKyH+meTSD90jgDDUo9/3KMybBqfA1RiW5k42OsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359497; c=relaxed/simple;
	bh=C5OeVmVc9RUqWQx2xLWOpeX88Xt1ishh/7V1x3S2xhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8QIatp/k0iIfPbO8ZGl9xZs+g+5gl/RGz4PQGXDhEQlnRn1ZjyfAl+88l3eqjLEYFhGy7rptbmsp75VjEr0GROOC0gd28x1KuPfGSjbN7r999axatfo9Bl4iwFOpdxOmNDletHAPBfSREA71HdJKepwGmlm/8THFzF4IxID0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0Etv2pH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0Etv2pH"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b042c0759so838819f8f.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359493; x=1792964293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+77y3oo4X91iER6HxasZRzsFWRhDOryP02cl98gD8s=;
        b=i0Etv2pHdqdDOtH/Drn40wJtjhf6YD6hXwev8uwOysg5fzTMSArXwinXXZKDVL/KVq
         hw2B+wlzRvui7mX1KaJP4FywAsos3+0VS2pOjSBLYTXz2ZM5D6ukoNN3DLgKYjFCFx+9
         StrWhKXZN6hc8lI3FmMGt1Womx+QIvgLaVNezzWds2se/Ixtkp8jTa/85Cz8jm4yxL4y
         aZt9xgHB4UWYVOQPD/Dj/FSwtODgwiorEvMJF19Ed8ofSuvtdOrRWpdRSjnLE++5YqNm
         JFd7DIS4n3/qiAfuu5k9HxynCtOYVptH3ttKSgX7Sk1DETMX4o83bN5/QHyVIEcyTWVN
         4Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359493; x=1792964293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s+77y3oo4X91iER6HxasZRzsFWRhDOryP02cl98gD8s=;
        b=o6E3dzfsK9to82AbODpOiB+3IbUQNHZWkU0GJx4VAvIq2fkHLde6uAghCR4/XKwzxj
         buYHXocpZDbYU9FcOwbcaB/eJhDiYVNchVKrAablF624O9x/oHIBk9TeA3FVSPIZjfor
         CNqvhRNivd4KZfDNuWHXJ13/Q1YfhStCP70LLjQ7xkpbrvzHek8CCRmacZgFIieaDBtE
         y6Mg5U/Rd5LgzkHhRu5WaODGraWEy7rkigwNg22d4UQ9JmazvaL0GdvcsamKbVa3g/N/
         B3hQH6u8bgx5ivmRvxq35ZSeVkRDwKxDct2jcE2rkdarEQ/ybiSOs8bQ99CvbyBlMIHv
         47JQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjCRyh0svzuN0IMhnrh66srUh23DGfm1b4FDEpPdvr3bEypsTc2zUihHJqxbL8kaYX8SF8ixI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIDPSmSiIAGoegXddTuCYox9J/+wigNzCgE9ZKJL8Iuj76Hqti
	uh60M3h1BWcDSid1bThbkA7UwJwRS8TNQ2nBkgGhc25ARCaJSwv7Pss=
X-Gm-Gg: AYBFou1/l0qKvL41iyyuKaZA51hdeQJa5ttOfiVINSep9QCJIFKjTKnUQL4KSQdNy0l
	9AnhGWYxvliqZP8bowYa/LBd84k5y62Spvj4KRW9F00nsNOUQNiaoZ7Lgle52IyMSBf7SenUqh2
	79Nl97KAF9XUhZZ6jEbq6Ett8Bw06HJkgW8wfoSAaTk+jBXR/Aq6/xLpU5xpHCkC8z8/tFhE6Ab
	j07WHlbVC1NHjPXXarOuG954M+qNZ7p/97KByBzTmnLlafwK1X0NFULyy9X1jonpNF0uSJkPOqu
	ishusQLRuYRjft6LunyK4Dn1pqgWpT6+yTvneY0+741JLVLSpIfzjDJfWB5WCew75fWNIbtvhXi
	ZPPM1KLm5ERg12iiUcSQuuicaEgWhdQeSIc7VxK7uTFpXK0aKKollJrrmbOpsi5CwZ7GE1+M8uR
	grZUBSm+Y/Shi9g/k7BXd1KzRdZ3Gz2ai8h8lE5UU=
X-Received: by 2002:a05:6000:400d:b0:48d:f58f:c98 with SMTP id ffacd0b85a97d-48e07fd288amr12216908f8f.40.1792359493335;
        Sun, 18 Oct 2026 14:38:13 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	"Daniel M . Lambea" <dmlambea@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Don Prince <dhprince-devel@yahoo.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/8] HID: cougar: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 21:37:49 +0000
Message-ID: <20261018213754.1951187-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018213754.1951187-1-tristmd@gmail.com>
References: <20261018213754.1951187-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

cougar_raw_event() accesses data[COUGAR_FIELD_CODE] (offset 1) and
data[COUGAR_FIELD_ACTION] (offset 2) without checking the report
size. A device sending a short report could cause out-of-bounds memory
access because hid-core invokes raw_event before it validates the
report length in hid_report_raw_event().

Add a size check at the start of the function.

Fixes: b8e759b8f6da ("HID: cougar: Add support for the Cougar 500k Gaming Keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-cougar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index ad027c45f1628..2dc135d0fd123 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -267,6 +267,9 @@ static int cougar_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (!cougar->special_intf || !shared)
 		return 0;
 
+	if (size < 3)
+		return 0;
+
 	if (!shared->enabled || !shared->input)
 		return -EPERM;
 
-- 
2.47.3

