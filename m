Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758343B3F6
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936260; cv=pass; b=Oupx6lAAWQ3V3X4NKRvUeL217thQ5E5xtQhpm1bZbwJUUkegjlUdUJvlREGwzcSphG9xltOTtqlnrDZkJyz608PHYB3B1yI662r8eA2MQKPYEafbDf0S/9bXIeaDFOlod3hmp2OUt2YZ2vUNM94TvMbLVzimu9BrCX1KjwMpVNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936260; c=relaxed/simple;
	bh=38U1s8GZuYMNUAkuLxbkuCyOG+w/gVbAI7eJbWfyuKE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MCkbWKUpSH3pUYOdBHO+yZH5rJurSmHde1S6zhd0AZCXeE3n74WxJl18V0+1JOCgHfOPK92p3rIYNHP5ru1mCYs4naujem5XN+9gQiI2AI03OsMMwWrZtO6NwG+PP2EgwElFRhmGosbKry8lZ9kgdX/pSSwTZnl1lptTEE24imM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5X6GJkf; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5X6GJkf"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba4257f97fso870339e87.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 03:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790936257; cv=none;
        d=google.com; s=arc-20260327;
        b=RsARPBqcsac5RWa2+IWyURpM7df6CSV92JwDzEG/3eN8SIeAQcPUCn2NZoKvP3bYjh
         qb6C6gfAjHPzC1rkeODn/TDVcfURMVPqJXkjjC8w33ORPqW52+yZ0mNiZul02f6uoF//
         ZLyOLgeV7IFA0+rV0MSp17cC6hdgsGMyrGhvHNIOeOReu+Pq40/JHReQoAbYsKMTIEzD
         huTbHZ8gHOk5VwjR9ohLMD83/tz09WvVqu0cSmYkdLl8PRh3r3wdjNsNON8iDlWoJqyn
         sclh1JE6x70mS6yy+fjCaY96UsjainVJYoTY7MAOxSQqv1U2I3VtTvnAQgnborbkHkVi
         vwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=JJn4UyQhX96Z2Uxh80LSoGTD5a8DL5VMxaJOGjyTlhs=;
        fh=nJp3Xqc8m4GaLoClrFhy3JKBGR6B+Wc9mUKIICfh2no=;
        b=aLSYyPup+KUuBz77fkwOGp3FFuzoRNgbArs1dyo5h1l1QZ8m/mmYmJhbBozxnzEM0Q
         6wIPZSl/8MEH0PGQhP7A2FEic27RyHYHLZgg1nCkOu8BI3H+ZulHXlZta1oOaLhchNbT
         Gdg+SSLKxiCeH0GWrsoopjSXWheUghqj6HjDBx4hyB2CPjEc/2XuvqRwbo5ovlmQoECZ
         KZh+QSrZHgseaEbslXdI0qMHHttVY0jMMXU4dsbM5E24kdBKwwUphPs6dY60AnNOcvK9
         BC1UrmWzA93WtSLuPuyGzrf5+zgYElkywwmsCElOutKrhbhnIwvXlaP2UQlutbN3/zAV
         Zr7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790936257; x=1791541057; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JJn4UyQhX96Z2Uxh80LSoGTD5a8DL5VMxaJOGjyTlhs=;
        b=O5X6GJkfnjvoI67iKpPBNYEreSkFCq16+Lt9X4aEO3SyY81sKKQRReFUxuYl2u2sI6
         3wtVKL3EQ0qMLRq0CKaN09erMesX9GSIwfxmBgy8Xwkrl7L+fQZPMzMgd2FslHYFQaz+
         rvXomdTlGWzb3lV+u7cO6QSJhAgO6Fqaufd+nJPxhN8Ma382rln2GbA2fOwVVQSNFst7
         gyL8ZSJB+nKVu2GS5k02jw3qHNeSYGEYiaF9rumlHZJU9QvlGpuao74txs869qfTnjG+
         h4mEGiet4dxFYzC8yqVwynecT1cRoXM/+w1STFCOLmBLy3HiWuvQUDXL8veS5VHHNaws
         ZFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936257; x=1791541057;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JJn4UyQhX96Z2Uxh80LSoGTD5a8DL5VMxaJOGjyTlhs=;
        b=Uz1qnnjTsWGP4VDe1lwNjH1wuwN3n1joGXQTU0l0x86KnvpvSiJlIN+tp6SphZrcRK
         OQ7wroESR6lxvC7lZWCpfIY0CheZrSShbUHpcXPcZPU7+pvShMSwOW1uS0GiB5TJDQQu
         GZFlGvPPts7vcH4iYWP0CTPC0A+hwidJfMhSv4Jwtw4la+bJaga8A4WvZ2dhg79bhMy7
         G4bHakXd+O+05DIQIr8ZQRXOLvPtF1rm6w4//Ge04Wz86VtgAa5CxNYHTBg7oNu7Itfb
         Nd8hlrCGygylHMwHPsjxgB1jEG7U39RRrtEsRJflosfxVEPv2pmnRnIrSDZyofHdp1uA
         F8pQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3gLQRbbj7OLnuhTZ0yEEbYpKOAxjO9zOH7LrLdLzPiEOpWBkgt5myv8Qn9/cuVBUBywGG0vQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJs3NSvDiudmQXF2lNLgRvbbw59j6Aiztl2NI9KceN0q6bvm45a
	Ns8cANSzshyzqpRa20lIq17kh1HnnY44pXyv/7WaOn9wCNzNYBdvTCV1R5lsivx4BjsotiJaGV7
	M3suvo0ZFNCqRlW1g4R3UsWl0y6zuwxs=
X-Gm-Gg: AYBFou3Nf01hwKhJIWrvfyAfsvKDN7f+N8ao0JZbXfCWrTG4nUMEM7cKMot0asrLST4
	rHFm6YfcarvZjxk0qbrx2nVdWoPiFDvgQy4ey5yTpxKIKI1ew7w2J9kdLFGnv0DV0c4/z0v4uMi
	fmxkcQzq6F7TKBBfloOk+zlIF3/3Cx0bDTCBFbIXtfRiWUr2zF/gS9rsju5VB87kYKMsoJ1fUwt
	Qqb42yFqyGnSujPLBBrD+4Q8iJpfCrOlU8FtJFhjeGW+z1ZnsM0fAr8cSEfOF5WMhsvha/xtY8T
	ilxfpPy3W8MTddMl3dShYEzRQ5Bbo74oBI5ktX6OUhWuRk+1ajd8geuyYnswJAPo3mO20xdvdpW
	HKOm/Y2frHzzJ
X-Received: by 2002:a05:6512:245:b0:5b8:f955:29e9 with SMTP id
 2adb3069b0e04-5bb9bb0ea6amr466276e87.7.1790936256817; Fri, 02 Oct 2026
 03:17:36 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 05:17:36 -0500
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 05:17:36 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Fri, 2 Oct 2026 05:17:36 -0500
X-Google-Sender-Auth: DS4RTw9_jQ-6m93tLNwVXeu3MWs
X-Gm-Features: AclHuK-GcpZNWEeqcuxePuhVqhwPm3ZOGC9uLM51U8kxbwgtnWHQkIW0rClOl3s
Message-ID: <CAANnmVBJ7NCV-SJrFtT9FO3VnaCK3xG5UzNud4xxoicxpY5qCw@mail.gmail.com>
Subject: [PATCH] net: ncsi: clamp filter table counts in GP response handling
To: netdev@vger.kernel.org, sam@mendozajonas.com
Cc: fercerpav@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	gwshan@linux.vnet.ibm.com, joel@jms.id.au, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ncsi_rsp_handler_gp() iterates over the MAC address and VLAN filter
tables using the counts from the Get Parameters response itself,
rsp->mac_cnt and rsp->vlan_cnt.  The arrays it writes into, however,
were allocated by the Get Controller Capabilities handler from the
independent rsp->uc_cnt, rsp->mc_cnt, rsp->mixed_cnt and rsp->vlan_cnt
fields.

A malicious or buggy NCSI device can therefore report contradictory
counts in the two responses - for example a GC response advertising
a single unicast address filter followed by a GP response with
mac_cnt = 255.  The GP handler then memcpy()s 255 MAC addresses into
the 6-byte kzalloc()ed buffer, a heap out-of-bounds write of roughly
1.5KB of device-controlled data, and the same applies to vlan_cnt
versus the vids[] array.

The loop indices are additionally used as bit numbers for
set_bit()/clear_bit() on the u64 filter bitmaps, so any count larger
than 64 writes out-of-bounds bits into struct ncsi_channel.

Clamp both loops to the number of entries actually allocated for the
channel and to the capacity of the bitmap word, mirroring the
validation the SVF and SMA handlers already apply to their indices.

Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")
Cc: stable@vger.kernel.org
Signed-off-by: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index fbd84bc8026a..fa1ed405dfbb 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -883,7 +883,9 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	ncmf = &nc->mac_filter;
 	spin_lock_irqsave(&nc->lock, flags);
 	bitmap = &ncmf->bitmap;
-	for (i = 0; i < rsp->mac_cnt; i++, pdata += 6) {
+	for (i = 0; i < rsp->mac_cnt &&
+	     i < ncmf->n_uc + ncmf->n_mc + ncmf->n_mixed &&
+	     i < sizeof(ncmf->bitmap) * 8; i++, pdata += 6) {
 		if (!(enable & (0x1 << i)))
 			clear_bit(i, bitmap);
 		else
@@ -898,7 +900,8 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	ncvf = &nc->vlan_filter;
 	bitmap = &ncvf->bitmap;
 	spin_lock_irqsave(&nc->lock, flags);
-	for (i = 0; i < rsp->vlan_cnt; i++, pdata += 2) {
+	for (i = 0; i < rsp->vlan_cnt && i < ncvf->n_vids &&
+	     i < sizeof(ncvf->bitmap) * 8; i++, pdata += 2) {
 		if (!(enable & (0x1 << i)))
 			clear_bit(i, bitmap);
 		else
-- 
2.47.3
