Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF343B4BF
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359492; cv=none; b=WI+cYvpxPc7ApuNBWoOWnnKmb1A4Jwz6gj0v2A4C3pwC1XmQQCjow4425+3bZEogL3JFJOtgzLebtUxt2Vt1l1WK1kj+Oio8i6Op5BnOUC7zQXQAwyz8+Gcy1pIbhScRf0CFKx79kLHoLKJLyDhNrNFwr2X84T6hMeFr/UkumKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359492; c=relaxed/simple;
	bh=e8wtLcepGB7m1WkPi16XBbmRmlD4CHncDaB4ghzbtZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxTLkC3l30t8Ytm7TN/27TBvGwezrSaSJuKf3041GfVBu20d9/RJo4qw1kDxkw6p5iY8hAUW4jGlJxmU6odng8WfUc7R4ieUGMq3oO4edOIZ2nPi5n5f8Rt1dzYhULmDCtt52Lo38jDUiQAg0M8N+dvgOQ6u+Wv5HRDjtH3r12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaTVsTvQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaTVsTvQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so10046665e9.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359489; x=1792964289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vAVYSc6bOeEhdjTuKd9lteCMjpiUz07VUT/q4gCOyPM=;
        b=JaTVsTvQULi/hn3sAYWpXKGTmeeDv6MstbUF0xY10bLosks7XXcsysCHNNaivTfz9n
         uNQlnSHrukHjQVv9ZHkeruS/6FMH+Ha2X8VfG/OU27d+MNeLaVGsySWmQEOgOIL9vr+W
         sMuHoAqfDwOruTQoOTyoaowYNntFP8dh94tbZnhXbfywWKoxUDROL8B7I8xFTb+Ctpk9
         /sLeGF8anhxSiFsfxj/wQvAE/2YJmt4WhsC+QbB5MYKXotIKCu1TI/X71Gittdrmzo1C
         MwyIxLX7WA2otdS11Mf7mTnERerV0Pehz02NvJrOu66xAezIq1sgYxoUwPuB7KmIKrEv
         pyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359489; x=1792964289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vAVYSc6bOeEhdjTuKd9lteCMjpiUz07VUT/q4gCOyPM=;
        b=jEmmwf1Ijz8nDJtgZmb+eL+jQ8uhiFDkBt2h/h3k6R6VAy8XryQyx1MqyRnApdrLaV
         TPWyaeXEcLV30RBnvU5FLGzY4heMwijkG/cuHHEAc6/BN9bfjC2tBfFbJ/8MDBCYsZcu
         DExr6ak/Q8LfBgyoOXufmY+4f624egQ/uocy/Az+7i0jZ9eM97/l5oxkTO/w9ZIiSlMp
         fVWndnEkNT7RxH66UeOcMifJsBHEbBgQEgN2+eiA+7OzH/82f12u0iKGWkPsQPsUySSZ
         8Bzw3EmhacnXEYh5quRorhFznf9i/MgSz/Jicm+tyovxnzyv6D3cRpY3Y6tGhv5D1/Av
         FgnA==
X-Forwarded-Encrypted: i=1; AKwUvBxldYFwvsBiTm2vwtLkRsPgArGtEeI46TLKMriw47JaHBKcp/tNFB5pooPRKhXtpM25ec41ODA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJ+sh9+baHzpWGkuszFnpjzmFc/rgsow5yui9IecAifcMpKq6W
	9Rs5LX/ENERMSSK7y9AC7CapyRYSRS2P45UGd3HI6ndwTJZcL1N1V5w=
X-Gm-Gg: AYBFou2WHBtJ33bncely57vNgMod1bUNny2hSNeL5EPvB9HkDgYFZe2reg/O+/fdCrk
	zE0+L5q+3n288rtQComZa6lUuXMLRUGKlVoQ0Jo6otKkz8rPUXxlxk6AvdtJhC4weOvkSGZsC3C
	8LPNYIqDvf0jRHvd1Hqr0QSowWbPB49PcQC98VtMjYfZH0iyTB002MoXBX5RqEcjz94FQiQ1aQP
	T6ZO7NF1+wWMl26qWXc8XgG/9dfIPR/wSwj0Ex1ShvRmr9UYXuHby9tFeuxPXcE+sixoEmUocQo
	kMAfyDg/Zg8mDkgQbKTqGcxJ0dmk3MydIP/POnEi5TwkSi8z2UrH/tijRQgC6g9M2yB77vAfLPt
	Ji75fquNx+/2b3l+PGtBp54efKYQKmFBh5nZS24HRuYJFfL6aS4CllpqsdKuSBoEx+wePJSFZLN
	1carfh2yynmXldseavuJGuaIpRy51JYPJ1F7nGt55z
X-Received: by 2002:a05:600c:4e8a:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a1d75f8399mr129264985e9.12.1792359489145;
        Sun, 18 Oct 2026 14:38:09 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:07 -0700 (PDT)
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
Subject: [PATCH 3/8] HID: mcp2200: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 21:37:48 +0000
Message-ID: <20261018213754.1951187-4-tristmd@gmail.com>
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

mcp2200_raw_event() casts the report data to struct mcp_read_all_resp
and accesses fields up to io_port_val_bmap (offset 10) without
checking the buffer size. A device sending a short report could cause
out-of-bounds memory access because hid-core invokes raw_event before
it validates the report length in hid_report_raw_event().

Add a size check before the struct cast.

Fixes: 740329d7120f ("HID: mcp2200: added driver for GPIOs of MCP2200")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-mcp2200.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
index dafdd5b4a0797..78a08d4d8f0d0 100644
--- a/drivers/hid/hid-mcp2200.c
+++ b/drivers/hid/hid-mcp2200.c
@@ -299,6 +299,9 @@ static int mcp2200_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct mcp2200 *mcp = hid_get_drvdata(hdev);
 	struct mcp_read_all_resp *all_resp;
 
+	if (size < sizeof(struct mcp_read_all_resp))
+		return 0;
+
 	switch (data[0]) {
 	case READ_ALL:
 		all_resp = (struct mcp_read_all_resp *) data;
-- 
2.47.3

