Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF83D47D9
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309701; cv=none; b=S4hP4DdSzafe83sS5STBQEz6e/m9QOqfFDADAwGvaeJhZRDLKYXZzrDZPScQmSFc71ee3wswuxEVLQ0ltDempI/SlNaw3JNzWA4qQPVqrLfOK2XSWSy4EFolH/z8dcvX4DZYS6v76CZV8HgFdP6dLZICsxmw1hvNMbw9FcFZKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309701; c=relaxed/simple;
	bh=ZipfWBVaKl0EMYAJTfhiM2oCEYXXGMydyR5EHeflR94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bh/Vu2Yo3nlD1S/F+oJ4pTpdsY9oryfljbkDItcjslvgQI6ic6jVy0ljkeRMKhgksx3zGwqD6c3RkuyDfYo0M5nTJn07LEPyLbPeUck25GYCJ6gebJUGaXilSfrB3pP7A+7sn+vvSi3zxaTri3j6Vl2Fj3xMT4nwZUUthp8UQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eKnExpYF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V3z1lWE2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DfQSAsox; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qHzkFwWs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eKnExpYF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V3z1lWE2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DfQSAsox";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qHzkFwWs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD1863E35;
	Wed, 29 Jul 2026 07:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785309685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qstx5oED49uWFmWin7WYk0cjeKFM3dh/wlf0Qa/El48=;
	b=eKnExpYF++UYtFBVGYQ+8XUuXb2/VIFkg1mlMEZxdNMFOJdVDOuIHHh402rzWopZqT+gzq
	Ng5dnOMRjavI8hkfHg3AhQaCK02ASUD278UGxEPYfkkX9pTIyV4ShsWhC6z3gLH+oRw1Lz
	w1znr6QKyCe2QXqA7tgMtkrrwqiS2u4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785309685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qstx5oED49uWFmWin7WYk0cjeKFM3dh/wlf0Qa/El48=;
	b=V3z1lWE2h3p7lMoPsAOMY/zQZx02NhzX84N4CmAAfxOSSEAihUjcgM82pRuLBvxZPXLIkM
	Rek9HFid0WWv4dDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DfQSAsox;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qHzkFwWs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785309681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qstx5oED49uWFmWin7WYk0cjeKFM3dh/wlf0Qa/El48=;
	b=DfQSAsox9xvq9T4+DSGvT7hOvH0Q6qOjbqLTHF6OflXCvkhd/5GdM8yzUCScnVfqCoae5G
	IFVV3OVnVpPVFq3kh35yRlUn+M1bNw77QivKdjGn8aBCrp3dkmPwJXP8WVgwDRS7/yf4lN
	p3++KuIduoSrFU22ssJr2lPvqLEEgFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785309681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qstx5oED49uWFmWin7WYk0cjeKFM3dh/wlf0Qa/El48=;
	b=qHzkFwWsJ2ekIzIAt1JnNozkq2JLcGCQjfLlEQx4al/HtS9zUKWbSWmKAAHljB79Z/yWfC
	vgfHzdCE5WS9BKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 686AC779B7;
	Wed, 29 Jul 2026 07:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TLqEF/GpaWoeDQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Wed, 29 Jul 2026 07:21:21 +0000
Date: Wed, 29 Jul 2026 09:21:34 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: Andi Shyti <andi.shyti@kernel.org>, w15303746062@163.com,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i801: fix hardware state machine corruption in
 error path
Message-ID: <20260729092134.455c06a2@endymion>
In-Reply-To: <ca6fbfb1-1e08-4b4f-b823-8312327d5b38@stu.xidian.edu.cn>
References: <20260512093534.348655-1-w15303746062@163.com>
	<ajqtEIAX_D5z_UW5@zenone.zhora.eu>
	<ca6fbfb1-1e08-4b4f-b823-8312327d5b38@stu.xidian.edu.cn>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AD1863E35
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	FREEMAIL_CC(0.00)[kernel.org,163.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi Andi, Mingyu,

On Wed, 24 Jun 2026 09:20:09 +0800, Mingyu Wang wrote:
> >> Fixes: 1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
> >> Cc: stable@vger.kernel.org # v6.3+  
> > Please, next time don't leave a blank space in the tag section.  
> I apologize for that; it was an oversight on my part. I'll be more 
> careful in future submissions.
> > The patch looks correct to me, although I'd have liked an ack
> > from Jean.
> >
> > I merged it to i2c/i2c-fixes.  
> 
> I understand.
> 
> If Jean has any concerns, I'm happy to provide a follow-up fix if needed.
> 
> I'll also keep an eye on the thread in case he comments.

No concerns, this v2 of the patch addresses all my comments from v1.
Thanks for applying this fix and sorry for not commenting earlier.

-- 
Jean Delvare
SUSE L3 Support
