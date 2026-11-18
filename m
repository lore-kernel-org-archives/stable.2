Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014780;
	b=iMD3l+tf0v2Xwamr/1cIJfh9zWVBcjBCod7RYrzJZu+qaNjQD6pb81q8Wsb/sph/JwYB
	 x5jc8b2dU+dn1VzTuaX3rvE0HwS6YPy9PHb8/gHOnQZ14AMkZ3BaxnDdJ/Oglg/8jIc+N
	 WA5X0NSi/BAhVRfuf7mdfxCKIbp0hfUc88Z328rXO8oYuXQ5ruxDUykSL+EQAdIOsZkRg
	 E275BMhpofiw/Rt8j/ktJF8jJxoUspTebMBCopeYSanKplW37Kkt1yoCYqC3otJPCZwT6
	 WbMsLI7LS0KPXm7fhjIyrbleRO+CsE4YszfaCWOvUKD0RC9zep9Grydyx5X4suwzcBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014780;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=TfseWjp/y0m0GsJqgMqK/PH4XjF0H6tZrUT+yotvQvk=;
	b=wCLxuAEqHVNrZK6E3k/mm4N5Zg4QbM38SzJjhAkyRzdx6T98a0/R21ZBuCutZTrRe2tV
	 B2mzOvDF9HtfoWLdhKbBMTJrdtwoBPRqxflev8pYzbqAXJaIfO2w7ZAl8/FwX7t4ThsPy
	 mOQVoA6BjZq97m5vep5g1T/3UwaF1jhAVjMuxyczOHer1yXMcl6bm2LvTjjh/jhT7udhi
	 Hv2h3RPNoAy2ZxBk8wR8vK3ABdQMZw97B89PbIiBr6Aj901LL3PCPUErV3wnKshz+UtQY
	 V+GyW+/4smDkC5q4oXP734mNPmtipsGnl0aNjqOWAwtSKVw3tMVcsq5Q4lgSOOE/WBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=06e0ZH9Q;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E8606A332;
	Wed, 18 Nov 2026 15:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 198E8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=06e0ZH9Q
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 982A81A07C8;
	Wed, 18 Nov 2026 15:12:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id DC2C42002C;
	Wed, 18 Nov 2026 15:12:49 +0000 (UTC)
Date: Wed, 18 Nov 2026 10:12:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: workflows@vger.kernel.org, stable <stable@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
 <sashal@kernel.org>
Subject: Can we get stable patches in a digest mode?
Message-ID: <20261118101248.6b90b25f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: DC2C42002C
X-Stat-Signature: fm3io1anhosccks6yakk5i76iu9hkt6m
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX197UQXQkyfjZ99N138g2bYcXXMQIvp3lZo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=TfseWjp/y0m0GsJqgMqK/PH4XjF0H6tZrUT+yotvQvk=; b=06e0ZH9QLAVxcIVv02EjC/xkA0HQnNIurr9POgFq2AZcFZCWZIeqZlEZvZzVy+2wyM6BTr056wUNsuTIvxUhXFeuot4zvrS1SfukgLRVw1QONgH2+54DlK10uG/y47vF5fMOwefEGFhdECcczR9bG57puF0vtC2cO/pED8rHkeQ=
X-HE-Tag: 1795014769-581673
X-HE-Meta: U2FsdGVkX19piUO7eIfGQJIS39DbtEZDUDpnvSnofIdrQzL6O5StAfS3/PM2lcyMW8IHZU5TnZffAx97zBL8VDnQF80pEdUrXEsia5YrknDWLKbGsoL/PC2toJDn8sD2EFgV0F+l3aKBUSdLj3/nV1mZo4LgeKQjq6xvFjVBwzp+BeE28mLBpVXo+Yxv9TRLWPHCAFhVjgF2oVxUVOACSssUnA9ggs5a6oeaP68e9xQ1jiVdu8BseUzLwslhLpqBbfX+TkXzLOupp8+1dxCv2ACfr8Y28Qqdlb0vD+p9+frjC11vx7fnOrcUBBImTUI0

Hi,

With all the AI patches that have been coming my way where I apply them and
they have a Cc to stable a new issue has arose. As AI finds bugs from the
beginning of time (when the code was first introduced decades ago) these
patches are applicable to go back through all the currently maintained
stable releases.

Each release a patch is backported to will be emailed out. Thus, if you
have a fix that affects all stable releases, you will get an email for each
of those releases:

  5.10, 5.15, 6.1, 6.6, 6.12, 6.18, 7.3

That is 7 emails for a single fix that went upstream. When I have 20 AI
fixes of old code, that means I'm likely to get 140 emails for them. To
make matters worse, some of these fixes will have dependency patches that
get backported as well, and I get emailed on those too!

I actually like to know what patches are being backported to stable. But
honestly, I don't care which stables they are being backported to. It would
be really nice to have a way to say "this patch is being backported to
these stable releases" and not a separate email for each release.

Now I want to say I really appreciate the time that Greg and Sasha spend on
doing these backports, and I hate to ask them to do any more work than they
already do. But because I get so many emails for stable backports I tend to
ignore all of them as there are too many of them to see if there is an
issue where one of them should not be backported.

Yesterday I added a filter to simply filter out the stable patches into
their own folder, but that means I'm pretty much guaranteed to ignore them
completely.

Does anyone else have any ideas on how to improve the situation without
causing too much work for anyone?

Thanks,

-- Steve
