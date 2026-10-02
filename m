Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655431716D;
	Fri,  2 Oct 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954558; cv=none; b=re6m9uChPdu/hQpKHcoYkbnhg/uvntCAPL3LomkqRn9i+Kt4ExlZqY+KzsJSxMcSQtASrX3Z/uxAkm8vgA973sGDfSoRYhs56mrwmg9FeoaZF9lKunxMzlaGui6F4In9eQoP+3awjMd3AQrEskfFFDs7KfVVP1EDTFEeyYMiBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954558; c=relaxed/simple;
	bh=iCKdoENT29Myd0Sa8zyexM8VUiecbAOkd+4hdRd13fI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DKlwiWI0KWRkYA7zUb17jLvbMP+uG+Q5xBr6mnR4c8JDCRoCHWyjDrWyIORQvYYxsT7e+jDbjI6i+/hgj0Gj4s+UN04kFGZ3NXP4ty4dbyGtlICfohRiQanYv8Jh2iCPKWm1UrGsYUVgy9/M+/54Y/L5+/Ki28Mv78Ht+YI5F5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=YUvr+qjp; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="YUvr+qjp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ucm31x7dysSHYLzvFhF/p4qFdU3Ga0hsKTWibMBN30U=; b=YUvr+qjpzsg5HmgHvtvjsW3O7E
	bvbo98caqljix9sEghWdAQZnZx1PaPj/2alSPG0PjN+6DBnn2q1FSTEl6RDe9YcOCTehZU5+1ZnXn
	IQhpw2c1QJXXqIyzl8kFMOU3f34Yh5ug+KbuFjOBqTuln/GBU7bwxZnyBc2JBO7HA7++oaig1b4EY
	uHyxRfXG0TtWSoBIkhzQaM8OpPt0n8j+pGaYuEmuxP1XrFNJFIEnp9V/SEnG7IveDITdgEcH8VDAd
	QGVsGrFSgz+yD6WsuT8+aZRWj9Cmh7GT/j1nCuEYcbpOcnFvQwFpOifeU3M6sJqFKwaaqnn4jqls9
	FN9EmUAA==;
Received: from [::1] (port=48668 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xCf5i-00000002ynr-348J;
	Fri, 02 Oct 2026 17:22:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 17:22:26 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: netdev-bot+sashiko@kernel.org
Cc: sd@queasysnail.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net] macsec: prevent AES-GCM nonce reuse after packet
 number wrap
In-Reply-To: <179094094507.434549.10343867236114211128@kernel.org>
References: <20260930203333.598733-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179094094507.434549.10343867236114211128@kernel.org>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <5a337607032eaf65e513af47177bc755@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-02 13:35, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [Medium] The code change is correct.
> 
> --
> 
> macsec: prevent AES-GCM nonce reuse after packet number wrap
> 
> With 32-bit packet numbers, the TX SA wraps next_pn to zero after
> allocating 0xffffffff. tx_sa_update_pn() used to advance the counter
> past zero, so later frames could reuse PN 1, 2, ... under the same key.
> This patch makes tx_sa_update_pn() return early when the stored PN is
> zero, so next_pn stays at zero after a wrap.
> 
>> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
>> index 78a19b1346321..233391acebb0f 100644
>> --- a/drivers/net/macsec.c
>> +++ b/drivers/net/macsec.c
>> @@ -486,6 +486,9 @@ static pn_t tx_sa_update_pn(struct macsec_tx_sa 
>> *tx_sa,
>>  	spin_lock_bh(&tx_sa->lock);
>> 
>>  	pn = tx_sa->next_pn_halves;
>> +	if (unlikely(pn.full64 == 0))
>> +		goto out;
>> +
> 
> [Severity: Medium]
> The code change looks right. The commit message may describe less than
> the patch actually fixes and changes, though. It says:
> 
>     Packets already in flight can still be processed after that.
>     [ ... ]
>     Keep next_pn at zero after wrap so all late packets are dropped.
> 
> Is late in-flight packets the only way to hit the nonce reuse? A 
> wrapped
> SA can also be reactivated from userspace without a new PN. In
> macsec_upd_txsa(), MACSEC_SA_ATTR_PN is optional:
> 
> drivers/net/macsec.c:macsec_upd_txsa() {
>     ...
> 	if (tb_sa[MACSEC_SA_ATTR_ACTIVE])
> 		tx_sa->active = nla_get_u8(tb_sa[MACSEC_SA_ATTR_ACTIVE]);
> 
> 	was_operational = secy->operational;
> 	if (assoc_num == tx_sc->encoding_sa)
> 		secy->operational = tx_sa->active;
>     ...
> }
> 
> macsec_start_xmit() only checks secy->operational. macsec_encrypt()
> never checks tx_sa->active, and its only guard is the PN check:
> 
> drivers/net/macsec.c:macsec_encrypt() {
>     ...
> 	pn = tx_sa_update_pn(tx_sa, secy);
> 	if (pn.full64 == 0) {
> 		macsec_txsa_put(tx_sa);
> 		kfree_skb(skb);
> 		return ERR_PTR(-ENOLINK);
> 	}
>     ...
> }
> 
> Before this patch, the first frame after an UPD_TXSA that only sets
> ACTIVE would get PN 0 and be dropped. Every frame after it would go out
> with PN 1, 2, 3 ... under the same key and salt, for as long as the SA
> stayed in use. That is sustained nonce reuse, not a short race window.
> Should the commit message mention this path, especially since the patch
> is tagged for stable?
> 
> There is also a user-visible behaviour change here. After this patch,
> reactivating a wrapped SA without a new PN drops every frame and counts
> it in tx_dropped. The goto out also skips __macsec_pn_wrapped(), so
> nothing clears tx_sa->active or secy->operational again. The SA and
> SecY keep reporting active and operational while all TX is dropped,
> until a new PN or SA is installed.
> 
> Could the commit message document this as well?
> 
>>  	if (secy->xpn)
>>  		tx_sa->next_pn++;
>>  	else
> 
> [ ... ]


AFAICT, sashiko is partly right. Reactivating the SA after PN wrap
without a PN update could indeed also lead to nonce reuse: before the
fix, the counter could advance from 0 to 1. Yet, the security fix
provided in the diff is the correct one: further PN allocations return
0 and the corresponding packets are dropped. However, I believe that
the statement "macsec_encrypt() never checks tx_sa->active" is
misleading: the check is performed in macsec_txsa_get(), which is
called by macsec_encrypt(), but reactivation makes that check pass.

The observation about active and operational remaining true after
reactivation is also correct, although packets are dropped because
next_pn remains 0.

Here is a rewording of the final part that should cover the comment:

---

After allocating the last valid packet number, MACsec wraps next_pn to
zero and deactivates the transmit SA. This happens for both 32- and
64-bit types of packet numbers (at values 0xffffffff and
0xffffffffffffffff, respectively).

TX packets that were still getting processed during deactivation keep
being processed and then receive packet numbers. The first gets 0 and
is correctly dropped, but next_pn is incremented to 1, which makes the
next packet take number 1. It then does not get dropped and may induce
a reuse of the AES-GCM nonce corresponding to value 1.

This race affects TX packets that have already passed the SA activity
check: packets that observe the inactive SA are correctly dropped.
Reactivating the SA after PN wrap without a packet number can also
cause nonce reuse. Keep next_pn at 0 after wrap, even if the SA is
reactivated, so further packet number allocations return 0 and the
corresponding packets are dropped.

---

Please tell me whether I should submit this as a v2.

Jérémy

