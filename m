Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483D3ECBEE
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493697; cv=none; b=CCPGwzr2TOrqSX9CvLdrL6fEJx7cLC4YHbLtuiACTh2uZ7buloXA7P2DwhGdAocIgh8KZ4XsNXHQGyv3ae0+Jorw/XIMjXWyXVKfYaP+XW5FCKzjm+E1fYbSt1TTfpIbG5bVzH7eZrjppR7T+P/PBHmBBdZVcHpfMQU0OlRkcNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493697; c=relaxed/simple;
	bh=2phH3ZfHFDdvg2/bP9D+soET5GwdfUErRL4cCMaXKUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxaZkYoINv9Kc7K4V3DhYWR/S421zQjvF8J2VL9YQjCwNNbf6NFNIfYgksp9Pxtkfe5Eyk9V9ijiSn/Gu9vAh5/6pC2/cJ+RqNFOtG7syGOWZrhqCbqpLH73AJYPZ9h632d58r3WtrYTkJsN4k7038GQkqcKqSx1G2xzX24MmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDuvdMIK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDuvdMIK"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-847a52edeb2so277056b3a.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 23:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783493685; x=1784098485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/B8K3OwEfLGyztVIceSp+/GraQ767IL1vulmM4eozHs=;
        b=SDuvdMIKcTkv+MEdHfuiDjdAEkKYZRwOgNObRMW3WxSl83ogYH9URwWrQrfwSwedpF
         41Ms3v59QMr4bT+SwCO0R9coShK3KcXc/0YlcM5AD440vla1oZKB/pa7f0o7CWI01Zf4
         J6Q8vsS0pEYSpoa4BSYAyIkitQBaiWTOHv3H/12bFpMomt0M2YWtXN/RVrhwFKB6dXLu
         WHR8YS2vaSUoXuvsHS27Wpnn1Ct2R57VbV3XNrPzmgDhNDMkseCr/hqaxo0MbP+E6hJW
         tbI7yhCvt/88lk94bv4RC+q1bo/mtssxqJgAgZ9XArFvyh23+nJKjx8fUXmu5lvSTTOX
         IWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783493685; x=1784098485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/B8K3OwEfLGyztVIceSp+/GraQ767IL1vulmM4eozHs=;
        b=OyxdyWFWQW++MuWFqPsdztZN4yOWiAW76tXdXu3XbUq5IwSmtV6Pm9TnWh4VHz0+zH
         fvgK1i8VPhXoHT1tvBzGqhfZWaU2wyuYSkl+Ah6M4n93rC/slKMg3xTmK+TU7cfPOn4k
         mKqT4fWe8JmKMNygFBaRvEzTuok4RLOGGBRVRDN4MmmpaJMGCR1D9TngBRSgBBsM5MjZ
         b6YkMy4MFrDqYsEQTRmjYw4NNwEcTDandLeuKwSHPBxhDmkZvbBb458kqOpun5Py7VPA
         hat6TFHJoaO1QYBeaUSbC4D3bgjSzna9iXiFapuY46W8bn+Oin9gQf3eor0llZvJ13Oc
         sn0Q==
X-Forwarded-Encrypted: i=1; AHgh+RqCY7kI27ggU0Swvjer+ozZ0E6XA4+DTS8iQfDmROqyN/gpgt4DkstxRbS80rz3OVko6FzvTVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF0YNd8CWW/gdkTqJ70xtFMVOyS8VJ5AVyr/IfQBrd5QhvrIbq
	LWdqPFIPWYjz+C4TXsUzHNloTdaq2Y4NJ0VqP1HTtkLBG/j/m1vb8Ehn
X-Gm-Gg: AfdE7cmNOCo3GtUqbc4h2xGmfAIO3V8eW0UQBZ7o+uFLTgOzm3Fv312I3lZdJJcGlqV
	wzpgdIZKyO/Fm+nEJwR/EEa6jTTxf5QmXHVLUIlB6ULOKSYsdQtdrSDD7Ag0jDss0tw7A+I3hE3
	o2jnIc6yKRUYWz+D2G5Et8/llpGVdSYWPmCxI219nYyU7+5XEy5pIfbKBR6j17tZZMu/2W3S6EF
	Iy63cqwUv5/44GQajpHTEOTGwqhrYZ0aboah/oNA0LYuA1PRPjeSsEH51CwGUvVvay6s2tHZ7eO
	ZEv2vY4BRFYnR4fXqCYermPprf4WMPI0AF0lLG6LrT5jUoYcd3jzLC1xKecTp32FN+t0z8HWYzz
	LCF5GKw3UyvmL2nwIQx2zbW6hh439c75ytnIsTqHLnzn1KEWE3EDrpINzlb18sILEHVEG7ZFQiF
	wUyYldlIkIQi7HsR1Dy1J+Jstn4K5NquN88A==
X-Received: by 2002:a05:6a00:3e12:b0:848:3dae:66e2 with SMTP id d2e1a72fcca58-84842ee541bmr1343367b3a.26.1783493684900;
        Tue, 07 Jul 2026 23:54:44 -0700 (PDT)
Received: from Alvin.tail8ccd9a.ts.net ([49.216.173.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm6643216b3a.57.2026.07.07.23.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:54:44 -0700 (PDT)
From: Hao-Qun Huang <alvinhuang0603@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Hao-Qun Huang <alvinhuang0603@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: reject overlapping move range after len expansion
Date: Wed,  8 Jul 2026 14:54:39 +0800
Message-ID: <20260708065439.1139937-1-alvinhuang0603@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

F2FS_IOC_MOVE_RANGE treats a zero length as a request to move data
from pos_in to EOF. However, the same-file overlap check runs before
that expansion, so a request with len == 0 bypasses the overlap
rejection added for same-file moves.

For example, with a four-block file, moving from block 0 to block 1
with len == 0 is accepted by the old check because pos_in + len is
still pos_in at that point. The code then expands len to cover the
rest of the file and calls __exchange_data_block() on overlapping
source and destination ranges in the same inode, which is the
data-corruption case the overlap check was meant to reject.

Move the overlap check after the source range has been validated and
len == 0 has been expanded, so it sees the effective length. This is a
no-op for non-zero len (the value is unchanged there) and keeps the
existing early return for identical positions.

Fixes: d95fd91c1ac1 ("f2fs: exclude special cases for f2fs_move_file_range")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
---
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..fdfef01dc799 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3144,8 +3144,6 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (src == dst) {
 		if (pos_in == pos_out)
 			return 0;
-		if (pos_out > pos_in && pos_out < pos_in + len)
-			return -EINVAL;
 	}
 
 	inode_lock(src);
@@ -3171,6 +3169,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 	if (len == 0)
 		olen = len = src->i_size - pos_in;
+	if (src == dst && pos_out > pos_in && pos_out < pos_in + len)
+		goto out_unlock;
 	if (pos_in + len == src->i_size)
 		len = ALIGN(src->i_size, F2FS_BLKSIZE) - pos_in;
 	if (len == 0) {
-- 
2.43.0
