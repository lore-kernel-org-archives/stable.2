Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54EB248880
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024619; cv=none; b=OOdl5rvMVJ6Y7D3B9aGwHn7jqGVvQaj7fkw47ZoALSAQVp7gK22vAMHeGHxBJUBgEGLOrWbuUArAKXstz70M+xg82b3MKY+X7VbN/NkpMc1ZgUHVfst9jc7phX2IydPhilj3GotmFY1wme6N15hAISXOQHjeW4ByQ2IE73lrsWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024619; c=relaxed/simple;
	bh=E0+VeT9tm+vZYltOxt+1BIvDMbhjzaTt6pQ1L2g5Hac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ELmdHUzmfOvKMAogn+oW17jW8o+l5TdgFTQsOkUXLuuSFlOTYV6hP/zjHKkHn2Ti5fLmAcUbmsn8gAXGq6rueX11Iek6nbqg6t9WlK7Qa224ajqBxeVpkMeVQn3G/imriyn9A2b0cz15h/vu6buCO2B9dmTtDnYdsrkXQmmOtNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=aod3LhyS; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=OJJznXqA; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="aod3LhyS";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="OJJznXqA"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F0Y1Ra4134700
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 20:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=MBFZjRkNZaLoShz4icw9A3S4SC
	eyo+a2ZXrJLss9QNk=; b=aod3LhySZ+NXWVh2m0H2+yut1FEa1vAOQroJDPUint
	FEj6ttWUf5Lu+8EZmo7pedsBrNjplnHEt9zmNz0GPV9r9oryUjV5PoiJZM2TyQR4
	04p5vX6Xb7eGMkwHSACIQ99xhlAkfb3Dyp2kHE0TYw9gJGu9i61yArUvYd6bwpIH
	i5GKozMp0A8UThOEp1RCtoE3DlTbB2lT8PQEWQD5YU6+bNsZep4zzDTmB5EizRev
	0kI5O/luy9jNowfCc6PvlJppgR43ShHX8Dd3MtQFDvFFCMg64kR8Gh/hlsnRquOs
	SQ83EM1ecsQoEY3vj/SNoCOi5A+KhmD71lOvmT8BlPtA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hae50b3fq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 20:36:55 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf7856ffso970492785a.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792024615; x=1792629415; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MBFZjRkNZaLoShz4icw9A3S4SCeyo+a2ZXrJLss9QNk=;
        b=OJJznXqAey9rYCbcDSJtx3LhhObrnzlOPAHbczZPWU5WXUk5U8V/00w3Cc3f5W/zev
         VPVZVRvTdMVgh5oV5NK07AXZyWqB0xw4mvxbJ2gGNNj7TMWsrGAz2t6aMAFBHjcmVIHD
         lHPBEaK1qtHwmMOSM0nolzENp+Oy15y9OjYMZubuluJ0tJA5EjFhMK6VXcKDLnmhNFuQ
         nvyaHsTWUd9ysyAeZyZ7vRuWxP7zMUIpLFJ9kxKOVJmS8J3kpfssO1MEUxzsbXqfemqk
         c+uIKOiHevxW2O+zdo8SRQYFEwTgPuWRIhTXQKO+5OsajAQvM+KG4eXUOkMYEBJDd0Ox
         /MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792024615; x=1792629415;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MBFZjRkNZaLoShz4icw9A3S4SCeyo+a2ZXrJLss9QNk=;
        b=LkMmkRohvOc80ZImNTMLDz2wFpSI3+bYMspB7U+prvo8xlM9UeWCBeCUR/ECBZnkRG
         C1M84CcgkuwPeY1vwU+MGl97pDA3D5emRm6g140ho9HKcNG3Nm/4O8EIaDmhXu5II+Tt
         tSYOEJy+rtjR8YJPmYioZ60xC03IZcsxH7uV3A1WCiZBKJ1FbYk0l1xwKx9I1Gm8gz7W
         PHknZZ+fDTOk7+ij5+O3mQhcTARMmoa4niIw/P2Fc+dLml8LcSJCXRVUNPR3rnt95aXg
         3KkC07NNYKYXLerTkvebJnIjzXCsgqSNgv9dPnSvu4MtaxZsOw9i2478KyAY/SyPo2MV
         r3Wg==
X-Forwarded-Encrypted: i=1; AKwUvBxzbVK/T6NfZlgp/lOwcZOrbi9OuSbFbI7ED1T3qeJJ6RJlbrwhPLWQVE4h++dV4Nh9qd141iA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbn3RvRPQuR0ic3b2SJ6O86BSsiT5tLiE3kEE0uQ2wzNPHy5Zl
	i1hsoK/W1yh6PvFlZvoa75c/4UH9MJJQF1u00ybK17Agz/wu4KSy1ARlIpaXBCh5M42YP2nx0t7
	uGgh1qpGsrrZw0gpoAzUoeGQjr110HKcUD2ae//WhfEBhv9h+Uobb8OkkIGPkNA==
X-Gm-Gg: AYBFou0kLi4fm8q4B31ksk2ct9rMlKJ39L+7l3oNbVhIbN/BHjmMcQGleXAssj/LOx7
	XjC61nkxjeUItX+dlbavAFdKxWd3SNQLgQ80QeYwULz4kHJc4Xx1WKfDxgiIXy5rdxPHH3JzVda
	MawkGSHTFTrRiSTpbpT+O5ZkN9Ogk2bnIPjF9pvgDsNDROYSzHO4XreHT9CqLLewRYR2rKv9Jsx
	0F5yG/Wch5pDktyNR/lvfAdc3n6jjl1AAI5cv1uj0H2KcHXkDhH5TPihnsXcbO9d5OCQnDfpF0F
	M5YO0MwTiT9rJCQgTs61ZVaTQP0jtFJ1scrob02+iLY1dNfU50mW9DyOsjBh87db4IwELY7RjVX
	BPDY3W16i12k882LtMSThBxoQu2e/UOqtCdPxIfyvhfCi
X-Received: by 2002:a05:620a:3713:b0:93e:6ee0:c074 with SMTP id af79cd13be357-93ebd260beamr2867280485a.38.1792024614752;
        Wed, 14 Oct 2026 17:36:54 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:93e:6ee0:c074 with SMTP id af79cd13be357-93ebd260beamr2867278785a.38.1792024614259;
        Wed, 14 Oct 2026 17:36:54 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50095a5sm630842885a.12.2026.10.14.17.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:36:53 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 14 Oct 2026 20:36:43 -0400
Subject: [PATCH] gfs2: fix the escaped block copy in gfs2_before_commit()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-gfs2-escaped-copy-fix-v1-1-ff917ec48fcf@columbia.edu>
X-B4-Tracking: v=1; b=H4sIABog0GoC/yXMwQ6CMBCE4Vche3aTtgomvgrxULsDrAdoumg0h
 He36vGbZP6NDEVhdGk2Kniq6TJX+ENDaYrzCFappuBC550/8ThYYFiKGcJpyW8e9MXeta1Ajuc
 oQvWbC+r86/bXv+1xuyOt3xjt+wc6WjoQeQAAAA==
X-Change-ID: 20261014-gfs2-escaped-copy-fix-1055ded37add
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792024613; l=1502;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=E0+VeT9tm+vZYltOxt+1BIvDMbhjzaTt6pQ1L2g5Hac=;
 b=cptjR8Wi5QYajBKi+2dNzereqKLFdldPrIPDRcekAy3LT29s8G+h9DpIpWr8+FkL8erFn7Qus
 8HR7V17pv46DIQK7gtNc52U7+DONYjsDgZQ5QkgdzlGHmHSnwIYVIKH
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 3KJoToq-DYMhRMWGl2ZtuittWn1tSM1Q
X-Proofpoint-GUID: 3KJoToq-DYMhRMWGl2ZtuittWn1tSM1Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMSBTYWx0ZWRfXxlyIz7Wh74g8
 9y4WwdPEfVC5yEXVhnNBahTkKLIr9I/+AorwaC5pncvS3yYb4B/H7WObBGEHyWz1e5mLiHxB8v3
 496ZKu3PChdxlFHLzY8/CARkXCWPpi7lO5aWv5ZbwMXaDAQmFMcj4wHk9d8n9/TiQySB18Auq2h
 7dpr5bo1CRHmCXjUygBHYHq+fKc0rJlgutGnwWrj+0faAMErTXcz8DT8Gd/JXcezHmDMIXwVNLo
 lqEi2Tl4hWO9ARBMhjx0SsfjlmDRsfH61DtnblN5c1Ai/VpIgwsVvKICJlWYBmUIKir+TJ7afdF
 uFQLuvFDYe+1veXpXk1UDT16FNn8TzZ2VDE9tB3jGNYWx9ZlceELD7JPCmq4mlJL0iVv6BfsP/6
 3kR3ZKhlfirC58B4h6roluI5MSFdnxbfOlPtBl/PdzkdujiQUaOVSLQHFLLOwcT5I/8CMf4cr1v
 WMBS7fwCJIWU3SBNDhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMSBTYWx0ZWRfX8v+CmC/T+898
 LDYGGYGbnfhsfigXfP7Qe+hDmZhhsL0SeS69FDfGeMfWUzfXw71GoqfH4E5Vj/Aj74CJ7B536hd
 RMQ+26j98LTx/F9OHqhxvgcIJrPRQCxdp0QmnIQB3/WKyledi4OM
X-Authority-Analysis: v=2.4 cv=fKqsTpae c=1 sm=1 tr=0 ts=6ad02028 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=VwQbUJbxAAAA:8 a=bvDx6QY01viD3ml5MkMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=10 phishscore=0 malwarescore=0 bulkscore=10 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150001

Commit d68d0c6c3fc7 ("gfs2: Use memcpy_{from,to}_page where
appropriate") made the escaped buffer copy read from the mempool page
it had just allocated instead of from the buffer, so the block written
to the log is whatever the pool page last held. If the journal is
replayed after a crash, the block is restored from that and the file's
data is corrupted. Only escaped buffers are affected: jdata blocks
whose first four bytes match GFS2_MAGIC. Copy from the buffer's folio
instead.

Fixes: d68d0c6c3fc7 ("gfs2: Use memcpy_{from,to}_page where appropriate")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/gfs2/lops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 77ef22eab368..16fba2108a4f 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -689,7 +689,9 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 
 				page = mempool_alloc(gfs2_page_pool, GFP_NOIO);
 				p = page_address(page);
-				memcpy_from_page(p, page, bh_offset(bd2->bd_bh), bd2->bd_bh->b_size);
+				memcpy_from_folio(p, bd2->bd_bh->b_folio,
+						  bh_offset(bd2->bd_bh),
+						  bd2->bd_bh->b_size);
 				*(__be32 *)p = 0;
 				clear_buffer_escaped(bd2->bd_bh);
 				unlock_buffer(bd2->bd_bh);

---
base-commit: d0c4bce31a579216780b990a09250f15e00f38ff
change-id: 20261014-gfs2-escaped-copy-fix-1055ded37add

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

