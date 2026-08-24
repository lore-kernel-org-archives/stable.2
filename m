Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC090456E0D
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587066; cv=none; b=MlBoc0BoSPAdn127B312Ey3zlM6peFvNPiVyYLvdttFzAblsMX/c8iajvz1PQn8XA2B7UAqy/434xyUzQIWOQ2pYEJCxsrkiI+2xjAUO//n/y57F90rOQZIMZQiswha+BaHHBn+CggBGxFA/QSNKEiYtsQlHNXcJ7AMDjapTSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587066; c=relaxed/simple;
	bh=Z5tAT/mbHuc59Ui9YJ/aI3T6aE8OciceI47oDPSEdQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YH/U3aP499zUdx9w/dw58sXXBZ+nAaX+wVLcuyLVf4ip4Cnv6zGa2pBIu/v7BrDv48gEgln/Dw/B6lG7RIYHs95ra3AAAQvlUvXsm66aBg3cAfH7cf+lmYjsrJR/bogqpXMaOYCrZykM7EJj9Xu9xocABfqrpPVVGocUmNjeohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho3s22j8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho3s22j8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4491238a91.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787587064; x=1788191864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eYsIP6CPJ/D9oHNd/lqnV+fm0zd/HlHbMPOSyKSlzQs=;
        b=Ho3s22j8XdqPRI0rJsTmxVW+s89FaenZFStIE/J/Ms7190D7GLMT3MXGnE50edf0UI
         qfR2P/XDt2Ey2hLxNmcP3lVkxxtGHeTSDw0gssNOwZPWIRzmtb5sN+gLa/99da4uWbpU
         igbyg5MdUqdc0W0qLqWESde3DUaTVNkHtzjkdQjH1aclE9XzB5S46kO0BegW84Oy9hH5
         KLglddZuvEwaSePdguwvB27/JbOfXTrEfbMA88nHUnaIQU2zcxuKCfYV7rqAviDMKpX6
         ykZaQ5DO8Pkr6QIqjkYBu9uZRkqccxVmcR/Pw/Gzj2TIiSGL+qNtEO7B2pIHNyu2ZAkX
         Swxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787587064; x=1788191864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eYsIP6CPJ/D9oHNd/lqnV+fm0zd/HlHbMPOSyKSlzQs=;
        b=kkXVn2PTIUC3dqomXmFbjnZIs0CzdV6CbGM4XEj6gD19b904by3TVAFW6CQM+P51Qr
         obNukC6tqbHV+loB1G/uLi9zaPnPY0Nj4cU3nwCLJuc8lmAxlqG5u57NsOTDpLWDs0q6
         y/BQ5u/cfFWZz1iIVDahWZ75LfQc02r/Neixr17n0kD7Ssg1KNxfSju85ynaa+DkBL3U
         n1642UgM31iu6wHplbdE55owjsrWDVekj1i6BM/M6QJC8q0MZPP3vEtIY6H3Xcfv+Dlq
         Z8a7BsXNfJV2fdWv8cIXE0Y6X74xoq4myKjZ9xaI0+7SHKSW0qC3WCi+0D+naXOOd5cR
         YgOw==
X-Forwarded-Encrypted: i=1; AHgh+RobI1cn87clq3tlg60hWN+P00RBladhpAQmOOoAZw8wl2+2y9jJhdwYD64mnMZR7hKwBghmR1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mfaMWdsP1ZNHozNtOp8EvUBwE78KfGu5B89zz9Mb0rdJMtGIci
	apPYo67zRaHOJ+nihuGu/ro2mL0aXnNEQ8J3rqUTz448O5jw6Rp5kxUw
X-Gm-Gg: AR+sD10QoV1h7mtUidkHLv4SxNISyWytOHwbbwab76utnLhF9CsPfDGJvuLF+95mrDV
	qSZ575xXLc0fd7IjHt3zdhUaXGmPxyutpvEZDUmQEY394+XfYET28X4bR+zPCpVKaq1OnPVkEkQ
	ciKMlrHnEu+0y+XevWd/j+0AnE5Y2eO6paoXY6jTDbY1QgkOD7QZS4zLgeoEhxIfVJNs2e98GX2
	ie2EuSTnCjmtRfnSekwD2KCD9rAyZ5OJvgdfBxA+a5Da3Bbb6YDz14Y9xhcwzv2DEUNgvK/P/WH
	npkPahg/Jiy0GHL6a8CXRPHuTuEQymX560bVK+4lYD2QyjQq0jlicVUQrkF/WE30a5m187a51Le
	DKalxXIQ7uKkm7kG1p0Wd4o3HEtEzvCUp//Qm4ZtKtm0e/PpagCsZdK/PT/kBdhMSj/fhXgfrar
	9vAdM5jEQcDblefOZqgZXbldktqx/gg/hKZjYlueN2vLrx0ea7zBIb+fcu61dZ0c30wdCHTeDXx
	VJXbmfGSzQzhKtQ7P8TQetVBMR0/vlBxvCEBD80+JO+at+VYdUkySu3xnkfKix+hFoehg5k6lSE
	Gd9bAtoHZvVunR+REYcj/q9rMCf9mFxEE3vBm+jwo67sf0XHiQEPcbEJjfN22TmyV3r5VWr5NZZ
	0cmBB/exveNUdvs+9EmaEQ05gD2yZsvlXbrXkC45IFZSUV7I=
X-Received: by 2002:a17:90b:1f8d:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-395df67778fmr36770322a91.15.1787587063832;
        Mon, 24 Aug 2026 08:57:43 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d37cesm32210430eec.15.2026.08.24.08.57.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 08:57:43 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_codec: validate vendor codec count length
Date: Mon, 24 Aug 2026 21:42:36 +0545
Message-ID: <20260824155736.54542-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <CABBYNZJxXFt3N-hNQ-RPSe379uw9qfwvKL9yncQ4a034_9d6hQ@mail.gmail.com>
References: <20260823161638.32348-1-acharyalaxman8848@gmail.com> <CABBYNZ+h-m9YQCim5Zm2_sgARZh+jM=POFYX_zTQ=xYUdxz-vw@mail.gmail.com> <20260824144051.50010-1-acharyalaxman8848@gmail.com> <CABBYNZKJ10anQiThzYturqWyRxhnKY-xOMKhKHF5ysx37VmHkQ@mail.gmail.com> <20260824152029.51492-1-acharyalaxman8848@gmail.com> <CABBYNZJxXFt3N-hNQ-RPSe379uw9qfwvKL9yncQ4a034_9d6hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Read Local Supported Codecs parsers consume the variable-sized
standard codec array before parsing the vendor codec count.  Although the
initial reply-size check includes a vendor count byte in the fixed layout,
it does not guarantee that the byte remains after the standard codec array.

If a controller reply ends immediately after that array, calculating the
vendor codec array size reads vnd_codecs->num beyond the skb data.  Use
skb_pull_data() to validate and consume each codec header before using its
count in both command variants.

Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cache details")
Fixes: 9ae664028a9e ("Bluetooth: Add support for Read Local Supported Codecs V2")
Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
Changes in v2:
- Use skb_pull_data() to validate and consume the standard and vendor
  codec headers before accessing their counts, as suggested by Luiz.

 net/bluetooth/hci_codec.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 5bc5003c387c..7a7e813dcdda 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -145,11 +145,12 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
 
 	skb_pull(skb, sizeof(rp->status));
 
-	std_codecs = (void *)skb->data;
+	std_codecs = skb_pull_data(skb, sizeof(*std_codecs));
+	if (!std_codecs)
+		goto error;
 
 	/* validate codecs length before accessing */
-	if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num)
-	    + sizeof(std_codecs->num))
+	if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num))
 		goto error;
 
 	/* enumerate codec capabilities of standard codecs */
@@ -161,15 +162,14 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
 					    LOCAL_CODEC_ACL_MASK | LOCAL_CODEC_SCO_MASK, &caps);
 	}
 
-	skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
-		 + sizeof(std_codecs->num));
+	skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num));
 
-	vnd_codecs = (void *)skb->data;
+	vnd_codecs = skb_pull_data(skb, sizeof(*vnd_codecs));
+	if (!vnd_codecs)
+		goto error;
 
 	/* validate vendor codecs length before accessing */
-	if (skb->len <
-	    flex_array_size(vnd_codecs, codec, vnd_codecs->num)
-	    + sizeof(vnd_codecs->num))
+	if (skb->len < flex_array_size(vnd_codecs, codec, vnd_codecs->num))
 		goto error;
 
 	/* enumerate vendor codec capabilities */
@@ -214,11 +214,12 @@ void hci_read_supported_codecs_v2(struct hci_dev *hdev)
 
 	skb_pull(skb, sizeof(rp->status));
 
-	std_codecs = (void *)skb->data;
+	std_codecs = skb_pull_data(skb, sizeof(*std_codecs));
+	if (!std_codecs)
+		goto error;
 
 	/* check for payload data length before accessing */
-	if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num)
-	    + sizeof(std_codecs->num))
+	if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num))
 		goto error;
 
 	memset(&caps, 0, sizeof(caps));
@@ -229,15 +230,14 @@ void hci_read_supported_codecs_v2(struct hci_dev *hdev)
 					    &caps);
 	}
 
-	skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
-		 + sizeof(std_codecs->num));
+	skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num));
 
-	vnd_codecs = (void *)skb->data;
+	vnd_codecs = skb_pull_data(skb, sizeof(*vnd_codecs));
+	if (!vnd_codecs)
+		goto error;
 
 	/* check for payload data length before accessing */
-	if (skb->len <
-	    flex_array_size(vnd_codecs, codec, vnd_codecs->num)
-	    + sizeof(vnd_codecs->num))
+	if (skb->len < flex_array_size(vnd_codecs, codec, vnd_codecs->num))
 		goto error;
 
 	for (i = 0; i < vnd_codecs->num; i++) {
-- 
2.51.2
