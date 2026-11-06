Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969174;
	b=GdSphltNteF07A+PVO3jTYAKwi6hRpKTI8Sj7wtK5aDQhZAFICD9+5dxy7nTkiyMbyIF
	 /IHYhOmWMsjINbyPLoBUncEq/R5p0Z/mHAz4IJTkoIzy83Xu1hZ4FgR+sc2CYlnR9QXo8
	 RCX4ErytPqTtH9GQso0hD7Vd/mZ25oafjNoXTd4DGqD7b7XEh3Qingnj6vjVlo0zKC2RH
	 O+kIcKMxkInArQzDYy8yPqsEgfsJva44XrcRxe+ADmbrjzD2hPwNicQVFOK4C5yDNTa0o
	 2s4Di/rnWlElm2ObZqq9BIMLvENtjx1lN/4bt/Ir/ihsje4C5ElNLwWTSO3/6TMgLrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=to5ZYe36a7Xl7ja/Fvmb8moZkHvXAEhFxAyr4iAV0io=;
	b=SY8HNhKSLHU1wz1l4TE1pAQTMqhB7vbNQqOzQrSRcz2krGY1PgqjWb2OtiDKN31fCdit
	 1y2bTiNwOlYDGjgcLKeyXhWDDLEeRm4gH5N2RgG9qwLM+a97/jVcTu3gSIERyZeQnyxEc
	 ZQxDAepOZ+eg4AAX1kQfkxFiZBXFwSH+7c7LJuRweK5lliokInFNM+IZQPiwsqRTEN/TK
	 IAznB59W6OBqixcc2uRLr0Bu8BfYq5aRj6CcIHUgE+eo1BbQOQ6oLEQeuK+EXHcXPmqWB
	 FgKs4LHSuI0EEyx+ISNzGRDXJzbtc0DCNU6PDDIAZcu94hTMipm6+Ded0zgQTdELmfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OtI1fWwO;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8A606D826
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42E8A606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OtI1fWwO
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so480949eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 04:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969173; x=1794573973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=to5ZYe36a7Xl7ja/Fvmb8moZkHvXAEhFxAyr4iAV0io=;
        b=OtI1fWwOBO1UK/xBVF361zKX5pNVC4vlOBT8ozO8B7jwOHG6ejWk0PFQSiaUO6goh1
         lqLolKuP/ZuEkvIasGgWRMlSwGUPYOU2TU7EAJBPDqdrcmOlq6Gv/y/kjwPBFsoMk+8g
         HLztc8XnbL13xQXeFLXuyOuZZ5+5QTP0FgLCdYiULs/twiNDdBYStOmozF7hKRfh+PhI
         pChKKxj9DXmURGSQHP92wwb7befLbFwo6kZn7sfpYZ7RGTmsMd9807/pXqyYsbZskAzG
         GpLDAKkvHnHuHMAStFBet+Rz5WhPr2n+9S1T1PRdarZ/DSu3iqlO8geZpC5DtSEVHydB
         xitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969173; x=1794573973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=to5ZYe36a7Xl7ja/Fvmb8moZkHvXAEhFxAyr4iAV0io=;
        b=D+B2gLUeq9aRBFjwNULgNSu37lQD3bi1cUhjWarLoxYSta5DUVeH06qSfKJkv2KNf7
         exHdHRJdnKQUGTIUoYERcMLMD/0JST1I0LwO2TDAiRgaWZmnWj4Mg7n8eiS03OBRrOYA
         b154/mSjQH5Wh8gJfOQw5tHVAoUfy16pYaoQy9b3WAedh2h45vgmCXPHVgxqJ8AybJ5O
         1jCI4UK48hIWzkXkNZAHz2PzrlXqIfFFO5uUKigqTI6q4MiGfgIDo4L4+5h7Yf/hwjxt
         A8gXp+yN3VBWuZUAKnRC+tO0qqBkYtIbGd7mTMJCoE/NsL2soJ99ymADIbf6hcLd0SPI
         2MSA==
X-Forwarded-Encrypted: i=1; AL+hErGnjTTlFlKA2ZV0++E+GKAkOG5v8pET+TGC4Zu5c1VM40RUXix+yi6Z5vGbDWhwu2DazfX2Bh4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h0o8UnxJWs09pjpoUXfODHwpqE0EXL2W2cuBeHksXArhrkfFQ
	cm76iop0hXNmsLpdFdMVbFo2fPtQ4BbmaMEIAjYNKo4FKevdfiJmD9uN
X-Gm-Gg: AYBFou098qZjyat5E7X/dyjCG8QhPdoGc/Hu74P7ae2sqQ93X3K0oVG60/SvXUnKG68
	VuYTbZJNKyF7/6A6Hbz19pxZuzlpsUevAlEAmnEiHmvKKqOAHIMmbkgbUdHAqqxDRex60C2e/Aq
	emAQ6hgBlGuJXxvBDnXLGnz+zqPrfkr7oEU5kPs8eIZJzRvhZJYDFk1qaE05zZaQeGS+ZArOmpE
	EyhMATBEdO3+pmnfp5BtFclzk4mNv5We0I18yyUmXLr+bZZoWWgOqNwtTyYLa/ho1Dy6iODALZ9
	5BRVDtl13SC2QZzFzgxAR8O155xL6sKu4fB0mJfUfsajJ3YpO1NAp0dxGI+CqynP1jVKZk4HoWS
	phMFvQkkKGWRo1TIQjhsSuqmKqVlBJRTtaFLlVCFBsZV/Y3B4/HvL+keHY1TWhkmG/D00UXs8hg
	zr9mhAYy/dd+4XOsCq4UM0PKS4ZqXjnuO8eAa65Z2Y15XAfFCODGmcSDIWmT/v+ZsEOeQMtS27o
	Jo8chSM8PoU0pzjzO8LVZDMRFA+/nIkUSXP5U34f0EE1ZhjVuzuF+85TgBKLl6IFiIFEnCv1jzD
	OTz4EZtPGO6aDCtpVOx/U6Oe+PIioL13UkbAMck4+2+56EGeNbWRH6t3BEpRSGxlyQ==
X-Received: by 2002:a05:7301:424a:b0:36c:9afe:fcd8 with SMTP id 5a478bee46e88-36f772f9061mr3192845eec.30.1793969172763;
        Fri, 06 Nov 2026 04:46:12 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651eccdsm6802331eec.1.2026.11.06.04.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:46:12 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] ntfs: do not convert a named $DATA stream when making room in a record
Date: Fri,  6 Nov 2026 18:15:53 +0530
Message-ID: <20261106124553.2617026-4-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106124553.2617026-1-wahidzk0091@gmail.com>
References: <20261106124553.2617026-1-wahidzk0091@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an attribute has to grow and the mft record is full,
ntfs_resident_attr_resize() walks the other resident attributes and
converts them to non-resident ones. For $DATA it always opens the
unnamed data inode of the base inode, even if the attribute found is a
named stream:

  tvi = ntfs_iget(sb, base_ni->mft_no);
  ntfs_attr_make_non_resident(NTFS_I(tvi), value_len);

value_len is the length of the stream, so it does not match the
attribute that ntfs_attr_make_non_resident() looks up for the unnamed
inode, and the WARN_ON() on entry fires:

  WARNING: fs/ntfs/attrib.c:2115 at ntfs_attr_make_non_resident
   ntfs_resident_attr_resize
   ntfs_attr_expand_locked
   ntfs_expand_for_write
   ntfs_file_write_iter
   vfs_write

With debug output the values were attr_size 13 (unnamed $DATA) and
data_size 550 (named stream) for the same mft record.

It does not need a damaged volume. A file with an alternate data stream
whose record has no room left is enough. The fuzzer found it through a
single changed byte in a file name of an image from mkntfs, which made
a write grow a resident attribute in such a record.

Opening the stream by name instead would convert it with only the mft
record lock held. Its folio would be locked under that lock, while the
read path takes the folio lock first and the mft record lock inside
ntfs_read_iomap_begin_resident(). Streams are not converted from this
loop, which only tries to make room, so skip them.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/ntfs/attrib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index ce7c1b524..800e53df5 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -4932,6 +4932,12 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 			continue;
 		if (a->type == AT_DATA && !value_len)
 			continue;
+		/*
+		 * Named streams have inodes of their own and are not converted
+		 * from here.
+		 */
+		if (a->type == AT_DATA && a->name_length)
+			continue;
 
 		if (a->type == AT_DATA)
 			tvi = ntfs_iget(sb, base_ni->mft_no);
-- 
2.53.0

