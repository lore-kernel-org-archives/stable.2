Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468759;
	b=kr2LW7+RLqKOouMEIVhNPs8OBYDSMo4DULttJFU5upbIsFUV9+NwlJio6SgqP+WIGpbg
	 uxAWSmER81nF8WmWasKAEgtHqMSmeKfJV3kcnQZx7SnlYhAicURWG967TUZ5F9Krv6NgE
	 g+3MBuNg8phZWYZFbE2FzEF09GHnzPCCV4PpzjgElkWnd5gy1TDGInLvrfn0jZK2Pb9DX
	 5wLGtc+dKZgxEfCT5CbkFVq0rI5F6DgV4xEsQEWoMyQKfoJttg6uEEgt8TpnQ4+cl/Xu/
	 ll19J19GBQdYMdmS7WouN0MAl5A2jlBPYbsaIW9d7/+LzDCUR3uNcWmxs6ovr6jr7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468759;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
	b=Iap0y42iG4f8VzWdH+aBdTS8F8kXa3XNBMnBbYm/ToQEoBUGulW+0OJI0ZtvuX+8OjBK
	 ffJFLH5GK0T2CIU9Zbe01josm3ft2ZqDWEFur8X8U9UiofJtrGlV+ltWyvl2tm9SRCmsa
	 IGOJDyCpg7J/Rqvq93Z/eUV7gMx4zDWm3ZrrabdK06xvVpfbE+vZQrqgxnupKrc3QQAXl
	 KixGagefXu6K7aHrYqaJoS1n4vzAtbmd+9iM0TgSP9BRNoda4p4mNWA1rtjrhbJDKUJ2i
	 W4U6g78AU3y6u+tJdP9e9N0+3pr4GGxJwLrIGdpja7b1aT3jasPc/ZApMXpALN0cZfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AILMGxYi;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=P1c3b6ir;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E4606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 17:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 977E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AILMGxYi;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=P1c3b6ir
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDmRcS637088
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=uJK3
	1gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=; b=AILMGxYihFp4aa47RKE3
	ZkwqpaFA/qji9U4eUXttEpbkTO8SzOmW54oWCpknvVgzl3mlXPDw7zISGHqOQ5xm
	mUHbR90Kuj8TtuommrbOsRAj9DroiV9GS9MqnHAmF0hvy+n8Imz+EI0PPrrwJuBD
	yLxHW3VlUTIHnuCKnMf8tEub5zv7WtQp+JHjzoN40noj4J8gTkjguypnodlpcu/8
	NgMQDZnao+Vaeb8PuQ9M1WCCPQMUkREXnnKxJlcYGxMJK3INHKXWh0SSY6wJUkVs
	EvXP7WtDhAqEltlCeRJAkzQ4vOoU0PltSMQEjRBYrLSOk2LrhVu1cl6Kwbr+b/Sx
	ag==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hnakq2s0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:45:57 -0400 (EDT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7c0bad5ec1cso489216137.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793468756; x=1794073556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
        b=P1c3b6irGHvImyGvnQ0nMweIGYyTVneRgqNnM/lNCHCmlf7FDnymcHsh52eot3bypk
         v7Mj/JDqhwbA2lNtDilMd9Kde/ZUelcsn8pQRQO/nXlx1r0VurnRiTL3QTz6KwDx+6gs
         hTCoC9TWVukHL7ytSKOkLUoBVNbWVtKwa8bwfnO05IalBZpgSSEXAarpw0+PVPY0p782
         W2adDKXTpg0GpxTovxE1Xq1hLY5dcCfgbcftIDyMC8TBZLpWwxN5Dp4fJ07DSt6/gz2J
         FDvyjQXClF8DxpCSTFUJB2sOM79wTwbgGCQNa5x3V3v2VESoBbdnbPMSBHGgbWKtOjsk
         EHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468756; x=1794073556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
        b=vEZNIw7NiLOZJJ/hA0s1ffudyvHaNBYttatVyLuA8rYD1v/YT6Fm7jxmzUoYLblfeU
         p0GlWJ8RsUx9us70rn9er0t9OfL7AHfpUOtJKlCUrMk3vxCEcUPhKbdE9fqVKUJF55SN
         nRqO9wLWdOaRgXlcQESPxHcMR+7cTEgYuGrfrDEd5QnLI8Ax/RR0KOI158KS1TRmPKJG
         OaTYoRGGkCjpOS5rTOldrcII7tEcHZSwo6qvGyUnw6qdAXCZDLeFa1ey96hdsaAcss7G
         y6MvVv90BHctULV9At+kk3s7erFpgGbozhtUmQZVnKpuWKW/WvNNO5Od6ZCtWP1k8GKt
         JTJg==
X-Forwarded-Encrypted: i=1; AKwUvBz3hcwamojkPUhyTi+Hi5LAJCndzEqVvXyw3YwlLt4LKnt9vlaRB5P+CgVyj1VsfTdHcRek9Qw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxcbewJM2K2ZVSuZ0hBriZnxzrXkXVxKGeukE8bSx8tt2bdoSy
	zPze54Xm6bxNNCeh6A9DQfKhL4azvvp+8VeZpoqNb3Ytb17GB3rB1FN32YbWgZqwe9rJ9xuQKKh
	7C4pfHVjg1UkoJxlXmx8BBNmeiovV5n3/VZLunYPso4pXbH9NOtLedA==
X-Gm-Gg: AYBFou33x3l2LPiHYPRAn0A9NLd/8m6cQQB8z/ovYw/VSMv1M9q3p9906l1WOAzTiF8
	uSAIqrisQhzMK5tVFvUfkXoGFx704TS03B0QIxfPyInl2hSfzAbLzbLrGmy64lKS7xdQe4xWKPe
	qcSxsuNcgEV+xlmuTbBIOGaz5KO18dfhMxzZ54a+e0put2DQi/XuWJicWw4Akktpf+cgzG7hekQ
	svv9tEYQH1AYP34WfOBn8NLR/EAxET2nvqVgUAsKuhYWIndKlRdBohz+b0nLDZSet6/ncJzxUmw
	jisMY5QzSLWC5RGyYEUpq6ykdEmTb5nhCn2uBVE3KXgmhvVNlukAq1lcNXiZ9mSo0IBlz6pZAAY
	Mut8ljFELsEMes/HleBWmRH/DzAC0o5J+MYBYid8eXtQ4RddW5w3NVOAAhg==
X-Received: by 2002:a67:e103:0:b0:7cc:226a:f963 with SMTP id ada2fe7eead31-7d072cc29e5mr2098024137.28.1793468756666;
        Sat, 31 Oct 2026 10:45:56 -0700 (PDT)
X-Received: by 2002:a67:e103:0:b0:7cc:226a:f963 with SMTP id ada2fe7eead31-7d072cc29e5mr2098018137.28.1793468756238;
        Sat, 31 Oct 2026 10:45:56 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.159.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm10220667f8f.30.2026.10.31.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:45:54 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 31 Oct 2026 13:45:34 -0400
Subject: [PATCH 1/2] vhost-vdpa: fix pinned page leak in
 vhost_vdpa_pa_map() error path
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-vhost-vdpa-unpin-v1-1-94ffc9683256@columbia.edu>
References: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
In-Reply-To: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793468749; l=2574;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=2cfbyA5E1BgeuOs5GH6EveuwRPzjMvx0EL0D8iIR4TI=;
 b=ASB3o36C4fU3EYWb71QWR0b3OloFHUbllnjysWZc/O/WJMEbMyalbSxUjvtUsiJCSd5hwtbVN
 UV1UmC6jYICARYL7Qn5AYWXOvVzIfj1mcr+UxfTHO1a4QhwHfdFBPLf
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=NJBAaE6g c=1 sm=1 tr=0 ts=6ae62955 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=P+xgYyhW+KadpqoI50EQPQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=VwQbUJbxAAAA:8 a=Vli3z_CPQh-YiPf8mvEA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: vB0SdJABJU3ukSN9oKkE7uYnezP1dg5v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX3F5ifjOzHHmB
 w+L3hz89KUng8MwPfzmFahfLYxHjKtw8HB1/IUWYJGz4SjDdtOQt6CoyaXRMH6BXH9ZpLAFyevF
 Yg4XW8nKVnNzx+iEOroP18tOHdCWk+/NE74bI1Oj4Tz/yeW6YgPM
X-Proofpoint-GUID: vB0SdJABJU3ukSN9oKkE7uYnezP1dg5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX5ZCz+yo60Frb
 co/KLQB0RY9TIyzmnuEd5rcxkEu8fjK3uYIlGF4p2eCckH3T1vf/09YzzS/OSFkKVHFmU7MWEF7
 GvUhDydsgNgeR6mvxj+HYpdZIIHATIPXQqoPraZCJK3XtHPB2Ogj92BI8I2roErvMxkXc6ok3Xp
 eqlS/laDa+yB1pfTMTI2sEPtsh2wdjExdk2EQVX1frBUwveg4XbSA/u5N4ODDCc6GoWyHiXMlnV
 0G0MPwtD4vTNMI0GQg4eLyAdIU3qHHH80kdWDZEEfB/JO9g/s9YmfO5aTQVCMg3V0mMF+TChS5F
 7dr0vKgrJSRyGRWWG78yG4WdI4UUNSHhe+eUMc/mvyuIPZUcS9N+r5A2H+ueq9T4TH0KSH91qBw
 RJN+uai+EJsWY7aud2p/bdcNbEb9OBm5WUeFPCMHBLemTj0p34RGf87qOlfKj3z9l5Z1TQiJOFh
 Q38B+Ihzkn9A7NZ1Opg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=10 adultscore=0 clxscore=1015 impostorscore=10
 malwarescore=0 priorityscore=1501 lowpriorityscore=10 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310070

When pin_user_pages() or vhost_vdpa_map() fails, vhost_vdpa_pa_map()
is supposed to unpin the pages pinned after the last successfully
mapped chunk, i.e. the range [map_pfn, last_pfn]. The unpin is guarded
by nchunks, but nchunks is reset to 0 every time a chunk is mapped from
inside the current page list, so a failure after any such boundary
leaves that pending range pinned forever. With physically scattered
memory nearly every page list contains a boundary, so the leak happens
on practically every failed IOTLB update.

The pending range is non-empty exactly when a page has been pinned,
which last_pfn already tells us, so drop nchunks and test last_pfn.

Fixes: ad89653f79f1 ("vhost-vdpa: fix page pinning leakage in error path (rework)")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 drivers/vhost/vdpa.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ff7d90719171..d9af728942b3 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1151,7 +1151,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
-	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long lock_limit, sz2pin, i;
 	unsigned long page_offset;
 	u64 start = iova;
 	long pinned;
@@ -1187,7 +1187,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 	cur_base = uaddr & PAGE_MASK;
 	iova &= PAGE_MASK;
-	nchunks = 0;
 
 	while (npages) {
 		sz2pin = min_t(unsigned long, npages, list_size);
@@ -1202,7 +1201,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			}
 			goto out;
 		}
-		nchunks++;
 
 		if (!last_pfn)
 			map_pfn = page_to_pfn(page_list[0]);
@@ -1233,7 +1231,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 				map_pfn = this_pfn;
 				iova += csize;
-				nchunks = 0;
 			}
 
 			last_pfn = this_pfn;
@@ -1248,7 +1245,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			     PFN_PHYS(map_pfn), perm, NULL);
 out:
 	if (ret) {
-		if (nchunks) {
+		if (last_pfn) {
 			unsigned long pfn;
 
 			/*
@@ -1260,7 +1257,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			 * the corresponding unpinning will be handled by
 			 * vdpa_unmap().
 			 */
-			WARN_ON(!last_pfn);
 			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
 				unpin_user_page(pfn_to_page(pfn));
 		}

-- 
2.39.5

