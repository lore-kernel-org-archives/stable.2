Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314976;
	b=z8buRSweV80cLSEpWoSpeUysKCFHgRnQofnwYTS1ZSwMExVUTAVZLDTCt7r9QprP+Cvl
	 3nr8SdrLyV5K0Sl8NouJEdthhvNZ/JADPmAXJzQm4Y4CgneiEDj/ta9y6RlWjctygbmPS
	 CBviDof6UQkAYvYhlGyLevV+8VC9PwdtQi58CXkPdr4/OqE3rsNv1S0JYpKQAtZ0Ehy2B
	 o2x8pM2vF7Upk3eV/qJgRygw7SNLpcNnLiwW8BYMwHe75vniP2cG1lvTVkGLu5HFVEHpI
	 UR7s2ZU4Y4wj4U0bXVChcA+9FGWX5tcQ11ufNPTiuO6R77QCls0ND+OcKd6in9pstpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314976;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=/OjcrSn1MpMz13707Aoac+4FORWzX6JAbGi1LUWbsWY=;
	b=RLVi3hjP676D/IO2JOfw26MRhip1vM012Fm+VtUU+liNxbmGSj1hlTkP2jqZPnLooLs3
	 c/hGYZ/P142dPsMHtQ0+WOYz264LHEqarkR7wWxlaPoELNW6uvRN/i+COIO4KpWxsdhjL
	 ORFdO7JRLroNp/UrVKT6SCpa55Xq0oxRQJnWGWXo/o/cpsYM19QnSt/8P1NxI/s/Wg/gt
	 3pexVF1AMM/2vf0XO3r7j1mx/+vNjHPySNnm8b91sJINeMc1WEWTW24CbuMNiNnc877Sk
	 xnVD9db/Li37umuWA8h2ronIArMjIGdh3G5TplP540+bxTh5kzlKr+WEptQzns8TKhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DG+RhYN5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L9OGIrQi;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=C60X8M8N;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="ucJfpE/Z";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E8606A31C;
	Tue, 10 Nov 2026 12:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F4E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DG+RhYN5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L9OGIrQi;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=C60X8M8N;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ucJfpE/Z
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6689921EB8;
	Tue, 10 Nov 2026 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794314973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OjcrSn1MpMz13707Aoac+4FORWzX6JAbGi1LUWbsWY=;
	b=DG+RhYN5cu6+WIX30PCN3AfqkvmAztyuHhlzPKbsVB5t79HRFwOSdMCqOZhAkc9iVE4mIw
	5vM+DT+xo8NHXsmhrGOwJCJfh/Rzl+mY/F8FI45bXKx4G0pIenPkU7tcja2by8XftgLH0I
	IpevKoeyyyU/13Pxs8eNm/s9BopvRXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794314973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OjcrSn1MpMz13707Aoac+4FORWzX6JAbGi1LUWbsWY=;
	b=L9OGIrQi0+E5OmGYF/qqMhWKTtFRkcyuanQH58mwufRPRH31554fHOWoAENYfpQRmCzDwK
	4zeQyNzxH/IRYmAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C60X8M8N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ucJfpE/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794314972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OjcrSn1MpMz13707Aoac+4FORWzX6JAbGi1LUWbsWY=;
	b=C60X8M8NPU616/djs7z2m78DxETWOdUNIP0/OZOouseGBIfchDDxERhs6bJbCvULOwfUWW
	bV6vX7KqHk7si49LJzeTk8gUKK5Sq/gJ8nGLQ6vn88qA3xNECZbPql60GnkpdcgpSoAIWY
	okxDQNKcRSWuJ7rML1P+WbjSgiYqX/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794314972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OjcrSn1MpMz13707Aoac+4FORWzX6JAbGi1LUWbsWY=;
	b=ucJfpE/ZJn/j0gGv+xQ+IgHItN6gv1pCtnQfHuPpCky4a48FxZaWiEv43VNhut09WPR+vv
	+VC7qYqy4+SuC+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30E651339F;
	Tue, 10 Nov 2026 12:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nVRPAdwS82rDPAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Nov 2026 12:49:32 +0000
Message-ID: <fdeec920-0afe-4379-974d-e59e968f407c@suse.de>
Date: Tue, 10 Nov 2026 13:49:31 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-auth: reject incomplete DHCHAP messages
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,cyber.gouv.fr:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 6689921EB8

On 11/2/26 2:24 PM, Jérémy Jean wrote:
> Commit c9359401036e ("nvmet-auth: reject undersized AUTH_SEND
> payloads") only ensures that AUTH_SEND has auth_type and auth_id
> before nvmet_execute_auth_send() starts parsing the payload, but the
> DHCHAP path reads t_id before it verifies message lengths. A two-byte
> DHCHAP NEGOTIATE payload can therefore still trigger an OOB read that
> KASAN reports as:
> 
>    BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_send
>    Read of size 2 at addr ffff8880030d8364
> 
> Require the payload to cover the minimum DHCHAP message length
> before parsing it.
> 
> Fixes: c9359401036e ("nvmet-auth: reject undersized AUTH_SEND payloads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
> 
> Changes in v2:
> - Check the minimum DHCHAP message length.
> 
> v1 (2026-08-11 18:03:35 +0000): https://lore.kernel.org/all/20260811180335.4161138-2-Jeremy.Jean@oss.cyber.gouv.fr/
> 
>   drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 70136f6c22e8..a15f21fc41e4 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -301,7 +301,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   		nvmet_check_transfer_len(req, tl);
>   		return;
>   	}
> -	if (tl < offsetof(struct nvmf_auth_dhchap_success2_data, rsvd1)) {
> +	if (tl < sizeof(struct nvmf_auth_dhchap_failure_data)) {
>   		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>   		req->error_loc =
>   			offsetof(struct nvmf_auth_send_command, tl);
> 

Reviewed=by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
