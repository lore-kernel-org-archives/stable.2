Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769135;
	b=bNF3cq+Q8w7/cuW3vv1t5r4MOm2nsnR0VQyASscaE7bpvuEt9CSs8rVrzKmA2iZs+KPF
	 Moz5OlpCXP/ETqZOAb6xYO//a7+ULmp54nZ3wuRqFPCylMlANrZU5WUIQEFHJ/xbVphqa
	 0zHpDWRIkz61c75VXgP8TPdj6JZt6p3jaZQbJoqnf6mi1N2gnKAFxBd3oPVWSu5xydKIj
	 8MlU7Y4Q9CVreeyA0xsUPdKC+LI94q/bmg2ohWSCE6jtYB1bIjS8wwv6BxVtdmrMBLCg2
	 5P+QqKHXMfXzTwpUyFrIKKXw2zaq8AaXCcc3dTyfVwqOjA2zm/9fMDDFrfuP8OQ8/Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rfx8/QKieNzWuOWEnTbfc0MHqfPFCPFKkwmu9s+LsEQ=;
	b=Z8/ivtd1VZpSvobUAHIjuL94LkoujjYwlmbFZqcQJyLZ47kICEnpPqEeLgdl5BHf0/oL
	 2xz4iEtDMXBtVsOr26WJHKqoUV/qKT0G31+FOUCVcEhBAdEj93454eGqMICuEd2M80eYd
	 nFQF8kHBeVGm8+Cd3Hgm/sd86m+lJ7nOVwE5ACmogX1BBKXeSuZgaax0Q+S0OJfKrIE9f
	 KM4kFquQMGB5FC8gcqd6aT8LsVUJb30afqwczU3Fqaz56BK/kR/eXNTAeTVJgdpDKGkL+
	 YTrXcfULaf8BgRxp8duHDqTgTZm1jjWFv25nrduD0M3Vb8pay40CPZQ4ne3xjNOZbiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nEK1UAhv;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2A606A889
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 18:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F2A606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nEK1UAhv
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so5167798eec.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794769134; x=1795373934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rfx8/QKieNzWuOWEnTbfc0MHqfPFCPFKkwmu9s+LsEQ=;
        b=nEK1UAhvCMl01hvbouw9seyvdetcS4NCdpZI7UFQbJEL+LLeSBaHvb8KFWmRuCJfkV
         wVeZ4YSQsMIrpa+2X6DKlbJlgoTg3Y+K9dp6SFjRqFqKQ0fJb9nBqkZQ8su92THTj4gb
         sufwRzJwLHbceHUY3kSDb2c8k3MlubNfhEY5THsXsLbPNpl3rWaYcg8YosgRXgtxSVGo
         erSbOkTzlNfFR15748TrHeq1xlUzyuCnJ3xAObNHKEfVJlV86zk1lKT3ujHErpmuxIY0
         Cji2rpsQBLEULthGikGy+PXFm1Vc/7xa/aTxhP2SDpxFeL+ywg+3dAF0A8YOPmA1/ydd
         zfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794769134; x=1795373934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rfx8/QKieNzWuOWEnTbfc0MHqfPFCPFKkwmu9s+LsEQ=;
        b=VJZZEQ9nRcA0hnykpqRpTJ2iDKIJ4ihkprjzmi+6ZEhKSLtEqT7TaaotagRzN45Wa3
         qYvtkYmlEa6l1+HIbtIAeBuBk3uZnL5Bd6rzci0DYM2Ahm+Xd4X/GstEXH5LFtm/HgrP
         XI6D/2msxLw69BwOiESLMxYzpmHHImPqOf4/WCPXC+nFNWy2STmm2dk/zCkrTlWlM/wr
         6WWbFLBqDVGbSR7L6pKW2v2Uau4567OUarz5/UhnQLNkSH420b9GggWeqDQneZ5uYeHu
         l1qxAHHTY88X2sxsCbavhFQcjm4wC+tsxGAlqWrOFYvlZJM1kW1pWxsFXg6ZRwHg1k1R
         nWgQ==
X-Forwarded-Encrypted: i=1; AL+hErFl1Kt6u7Sh15lZdoFyCTUGZsca78gavMq3GMTClm6UKqARkT/jNWCAwpDxO5grKAqx+sgBHDI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mYscCSqaCdMNnRVM1y6xGqyO31u5K78m/j1lpNqANIjU7ierf
	+QBhi7eEHJ8mla7M4ReKuX1zc0Bq8S0TmPNmyXnNpSa8hXU3u+anx5Lf
X-Gm-Gg: AYBFou35Ylsn7SUaTXG+GD1cAh5EqEpPy/AmQa3Z9IP0mTB3GoZU2CtXWbq6m5ZwSuN
	KNbff/DvAnZQ8MfjzUSLYe7P3tTY21mZPjZpIYwqTnslLdqp8hAl2R9HyZM6BImFIQgkWx/kdbE
	PQZsHDEgdueNSuLLdY1U4lZ04BkDFOHyzon9uBvaGyMEeQ4dTVN5gzRvo/sd33cKzxCbVVWLxFd
	sQ3jUBKIe+/2jY+aEgrWSJgcfLZjtdMcyUxzivdWIvdBmuKV0xGEohOQ7hxKa6sQmR6mLjDq+JC
	IxCVHYYkCDlnPXQR9d4Mq7bT9khzxOTgBBQutmyBwcNfWme/Gv/4UZox3sZfcZppkGWf4eKGH5o
	QU+ECe+PWnfIKV5b8hy0F/FBw/XW/kV6Iqufp6+CCichEiJx5ycFNYMREQufkODW3FOzVgTnrvg
	gmAjXGb822VVQ5jrv6K9qYXIBzqHYGxKRfeiI4fRzFrPkNGvvWd22KVnPgZAsYpBEYT72J7dkxd
	Cna5VKkcglLzh3KHbVHznC8q858VD6OFVS/pwIwVNtzN0Q4swH6+ErsQ0s4OrUBXJ2hao3oX70S
	waWhcMUQ2T9A3k+wCuF0YypoAoq2cgN1MSLjGxh7tsiyQ+g+rZuQPe0ijVJTM8Dv/lPXQJoMgjo
	=
X-Received: by 2002:a05:7022:8f:b0:191:444:425 with SMTP id a92af1059eb24-1b50306832fmr7755064c88.2.1794769133806;
        Sun, 15 Nov 2026 10:58:53 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5329ec87bsm82306c88.0.2026.11.15.10.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 10:58:53 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless 2/2] wifi: brcmfmac: fwsignal: bound the MACDESC_ADD interface index
Date: Mon, 16 Nov 2026 02:58:43 +0800
Message-Id: <20261115185843.64633-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115185843.64633-1-maoyixie.tju@gmail.com>
References: <20261115185843.64633-1-maoyixie.tju@gmail.com>
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

brcmf_fws_macdesc_indicate() stores the interface index of a
MACDESC_ADD signal without a check. brcmf_fws_macdesc_closed() later
uses it as an index.

	if_entry = &fws->desc.iface[entry->interface_id];

A device that reports an index of BRCMF_MAX_IFS or more makes this read
past iface[]. On USB this parser runs with the default module
parameters. Reject such a signal as
brcmf_fws_interface_state_indicate() does, and count it as a failed
update.

This was found with a static analysis tool that we develop. A userspace
harness that compiles the fwsignal.c functions unchanged shows the
out-of-bounds index under UBSAN before this patch, but not after it. No
hardware was available for testing.

Fixes: b75c1a301b7d ("brcmfmac: destination mac closed when interface is closed")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index e81105154d6543..56eb2c2943dbe8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -1010,7 +1010,7 @@ int brcmf_fws_macdesc_indicate(struct brcmf_fws_info *fws, u8 type, u8 *data)
 
 	existing = brcmf_fws_macdesc_lookup(fws, addr);
 	if (IS_ERR(existing)) {
-		if (!entry->occupied) {
+		if (!entry->occupied && ifidx < BRCMF_MAX_IFS) {
 			brcmf_fws_lock(fws);
 			entry->mac_handle = mac_handle;
 			brcmf_fws_macdesc_init(entry, addr, ifidx);
-- 
2.34.1

