Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945427;
	b=Yllp0rF+cJ+ilSRbLnvz+XqUi3jLrDPNQnwOn/Vd1LeEHubNlhekTI1XyQe5d7S1u9cF
	 z0Zgx63ahuPL7mnHPaSF5ltmEahhcCucXt12voMKao33dtZKnF5DoxlTw9fOYefO/9fng
	 aJb9ILpZTJ8/4qwmiDrcluC7rH5HtZWeR4XXWbmA+VDPxVG1JdGAbR1Qhnvlb/M9ads5V
	 ixhF8UH4SrxuzPDLb3t284OwuasvG58TdsJ0uLOzLkkvbTjdNBu1ukeQIT1cHRy3uUupp
	 +xVhOjvoEi7jX45388YjMd/GV0VUWVBH9WNuJ2nl07YuQt836WScegGvgRIgehvBpXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d+AcYVf8reTWXFlWM/d+zw4B23JCw+ulbjBtfDhJI3w=;
	b=k5tXwgihbrAdrP+ohwyX4w/VnLE92pkNmvA/FEpYOhcTGjM1M/4vloC8JROAnh8/1MRX
	 SGEc3MqzTTC7XkITomE0GZ5CKI/ZwZJs630rKBER51EyQDssYiBDLhXg+JcfSwoTpeGim
	 IKif3bPaQiJ5kWPQMOkOcWD6ULi5eSE0UcZTe1j/ctSA7zK0LSLQlmaxF9vW+iXoouXrg
	 dYl/GVNzdgXiU4nDQXvKG31ryS3ha0gAKxw6iUJlzrCgUhYrKyVyl1Rdpd05RWL560hqj
	 nBIiw78jmV63nGnGGP+B61SHV98xmeC2Gf8/XJdEmmdT5KGYlqH+a5nhju5dcuC55UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgJ+pF1T;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398C606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 06:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7398C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgJ+pF1T
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso511034eec.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 22:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793945426; x=1794550226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d+AcYVf8reTWXFlWM/d+zw4B23JCw+ulbjBtfDhJI3w=;
        b=zgJ+pF1TwA5rO6fmWXsCVBbSeXfG92ete3mNtsVYgXGW6Ns7fKNXNVIWx0oBV4aJVe
         7H2gbfDNbJZyB05iNwYYvNivYUVJ1ABCOLQy7eLs9kgCYPvlJko9vOm302AJfCoAs5qf
         1wJBegNmtU9nqI/H0c1cXQ52EJIKUQrgEehWiEsYQcq78WGVSMx1PgL+MCE2lLOUn+Yi
         jLRMIgXcHN3GXB9UUT2k29RI8X9u3TwSt1ttEmkKPpkPJnz6Yq8mUUDvSUCiNjY9TZta
         nLoTBHA/OVOjK6cblyEtuhFlwKrvXZKzUgH5qKDA3B3f6UHdP9FTb4sJQZELuASZdpcB
         gBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793945426; x=1794550226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d+AcYVf8reTWXFlWM/d+zw4B23JCw+ulbjBtfDhJI3w=;
        b=1fHo/OC7NRxZ4vYH70mLmf+5xY0bZuY5HfrNdJKmv3wA1bp50CCGxK59SSNuKQKAFL
         rMDEZh/QAp6Gu+i8vREwWjm5nNvA/EQWDxIfN3cf0vr1U6f/Nu4PnE3CsRJd1f4hT83x
         iAsXcKGul68looQWJhaDrpMuCBFml3wTwhBok9GBHpXbLrMEu1xhNyB40fPjt8kBbKRJ
         P/UQYs7BgjJfGSm0TqxRf+UCZ8AbHRANEm2RmVseSmYchd2d1JxwG2WUVPnTkiFZxh65
         3uHJ9xKzozd1YWQIpBwFErSl14Gg4Ym/Swzz8AB2spY0k2MIArhf9JJPVCvN5fip/lUo
         QI+Q==
X-Forwarded-Encrypted: i=1; AL+hErHkUgPt5tjSD+LgTU9KhTa9I4jysER/z3LcmgW/k1pRr4QOr7JRJVobx9d2qSONOyQxtb5/CMw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GbXLOcINsGrfSKzi8XCuE/BwTzyx9Q+t6Aa0id//x+4xSA4FO
	KseuIWnfNTs4yiTKQ16BO+UtLYub7hq9mgs15rP//2i4Yr17St9MdJ6+
X-Gm-Gg: AYBFou0tSoEZ9y5vjhv7dEDcd7RwDg5PjepFaGtuMJp1jMYLG42V6clwE/kMhbypLUT
	ntFpzNtg5vAuAi+Wgjn5khIPIsGLCnKOxl4RwURQjrlXLS+n5iDMaTJwsi8SoSSkxglCgRKkte9
	Mjq86Fa3zbx4mIjftoT7jarAME9ZkaPFHPSScFjKFWo94xQbIxWPTfQsZb+Msh2IaAEL9XrSRaP
	3x7N353UblBl/0I6u7rym8XTdfUmVIeUFVwguQT/iPEWW0UD5pWofUElDiHqqzzg6eYJC0TT1n5
	lBIQWFbKz1HnE5WC4XO5TtDYI3sPHJuWQ0xGboWAYW5wucy4Cf9cm6ThpznOvEcOIWYj8M3iq1d
	S3R4eCCf0gNhFwLeVpxjoN1vexa3IXkdMULu5kOOtMk/SJ/Gg39LkI3AXCNChKMKbVacHJbKjcS
	QM67UNOBIl7fy317Wb/6djsXSokheTy2Xzru33BBiSvUqqeHXcTBvtpmi6XBBeREFcbgbL39jhP
	VcRAiJjTqZK2bW0ir8j59uomHq+5cSdwEY+zbt9VcapsfWn3J8DAUsQbesykDwnoQM+xjlJl7+a
	tZMW9JSZgMYozPX3TLaxchidagQMFOfqn3hmWefw3gPH/K2wfW6pD4ReIO8qMHfi9g==
X-Received: by 2002:a05:7300:c8c2:b0:36e:b3e6:ebe7 with SMTP id 5a478bee46e88-36f76326a0emr1961423eec.26.1793945426214;
        Thu, 05 Nov 2026 22:10:26 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651eccdsm3160531eec.1.2026.11.05.22.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 22:10:24 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix endless readdir loop on a directory without a $BITMAP
Date: Fri,  6 Nov 2026 11:40:04 +0530
Message-ID: <20261106061004.2338569-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
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

ntfs_readdir() saves ctx->pos in "pos" before it emits "." and "..".
If indx_used_bit() returns -ENOENT, the exit path puts that stale value
back into ctx->pos and returns 0, although the dot entries were already
copied to user space. The next getdents64() call starts at the same
position and emits them again, so a reader of the directory never sees
the end of it. ls, find and rm -r spin forever.

indx_used_bit() returns -ENOENT when the directory has no $BITMAP
attribute named $I30. That is a damaged directory, but it simply means
that no index block is in use, and indx_find_sort() already treats it
that way. Do the same in ntfs_readdir() and end the enumeration.

Reproduced under KASAN with a crafted image: changing the first
character of the $I30 name of the $BITMAP attribute in the root
directory's MFT record is enough.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/ntfs3/dir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 7ee1a5d4189e..dafd309e136d 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -584,6 +584,11 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	for (; bit < max_bit; bit += 1) {
 		/* Get the next used index. */
 		err = indx_used_bit(&ni->dir, ni, &bit);
+		if (err == -ENOENT) {
+			/* No $BITMAP, so no used indexes. End of dir. */
+			err = 0;
+			break;
+		}
 		if (err)
 			goto out;
 
-- 
2.56.0

