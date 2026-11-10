Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352952;
	b=dE1+LxfrHvf9ytbOfVRFQrW8k+sWY27C/lTuBEe6Wo+Q8mReEhavfoF1/j6in8pvQsxW
	 kuOCEUaOWrV+v6wyOmAcExbFf9vc3kRYUx7at5KJExhYUCU7GWKW1o8OBs2vaYThPz63e
	 AuWl6TDrywLrBxoGeF/9Y5RPCrmJ09l0V3Gyp8Cc4mTZU3JOsWgqk6YKDhjWdBpMU9/nr
	 EtzOHOc/2QwZm80bLpOvA3wtyqjxwtWyHfi+i2gF8eEC97YO39rBg3sEgK4OmieVoprUa
	 1rlBLgrwuONXeJSgXr/ImpKGPEu2kTXyPMlMjG8OYOEzTWF/ZlH9k2s2fNIO5nb9vNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352952;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=8Qh1jStSShwReJS+L1pYb/ypNH7m2/lryqyl1c+0iXc=;
	b=ifyT8PdUEGzj8+ZDO2zEcVtcsu/i/O/5MhfP1BfuPFggulgdSnvb4gM1lM7rTzuzpN6q
	 taWkcnEaV5Paiat/sNxnA9S+x3Fi6FKt6+IOKsv5nTj+sLd6s/S/TMGamiaEiOFK8F0sc
	 3i7521AnqGG3OAIi2yZU4w57GKRCRbYkqlRMPUIBdYK8Ml05WgfLiBggo3RogxLTTInr/
	 L+hyYQN1yTd6NAVtr+FYi1KV1s0cgFjqRPsqsu8t4yXYr1MuqUdSLQZbmt493zok1SLRM
	 272Cq4fBjdf0khK+vJ+/g3dWKbLZPFmH/LxG0WyvZ0k/sw4VkF7g44Ul9uQ9+rItMfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=g0VJJ8wQ;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D33606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D33606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=g0VJJ8wQ
DKIM2-Signature:  i=1; m=1; t=1794352949;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:DvNbAUHeIPSjSXkpmiC5g+UsX42U
   EbcN07HOWrCIgLGtTaAGqKW8yfxZx5wMtHSuJLSSpjsCcqthwIGmcLK05csX0bYLs1oHyDrib/8
   g1p1PXn8FIbccKnYEAxMgcuj1h+OiwBxXIZBnhV9P0c43OKtoeWU8UErtbtzHvPbm7821vYa01y
   vfxjZG7SX+Gguyc0Yb0wBKy+Bn2y+E4WrWXUIw7eGfN3dKEjR5OCPj7/aQAnRZWdWSXZFknexzV
   AZRE9jBCMVU90/sULC2co9bL5NhlJOQ7nSJx4cTzhxjEHSjrB2Ef3VkOItLXv2sPVTxgVVeo5kN
   5pn8zIMYP6d8XQ==;
Message-Instance:  m=1;
 h=sha256:
   DtErajMg4b7PY0ZIur4KkSD3NbftsxATaLYC2CV7g04=:
   hfo/qepYZjOQHs4qr0ULwVmf5OOMG08CmKfGvfBz2Jc=,
  sha512:
   3DzwceCb87n5J7VX+CCcLU75RR1oe4D/3okTvNUxUzCcpUtTF+pwcwXVGRk98YEob8U9I+AhTMSOT9Cqybfxyw==:
   oCD3lQTRknbNhQZ5JrJ8tva6phZ3wziNuiAEaJnxspmjx99zZ0KixxNbFRxi+9cwlnyxdSLJuHw9fYJvj4Fc1w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794352941; x=1794957741; i=deller@gmx.de;
	bh=8Qh1jStSShwReJS+L1pYb/ypNH7m2/lryqyl1c+0iXc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=g0VJJ8wQLsgWcbGNPQVZ/wfyw2dQiqx8eOO+bV35xXPFZ7s3ME+V2sLF8/A02boz
	 hp/eO9AjeV/j9cYY4I6aPGJ3ZvzmXXkBmtg1+So/wZDJ4Rzj2IeQKF9BjwL8mhpbn
	 anELG1bTXqldDGdqkauKghfKQy5j0eXrCToLefDbeAdc7JBaLuteSUXWuedAvW5AN
	 rrZvuSBUDxtE+81hxPmfdByCPRuGcZ7+B35WI6aCnTrwU8z339FeUFNI107tmyNbP
	 ryazmSkqrvdNW1jdeDuV1cz3HpNwCnR9s/Hmkt9xhaU1b99Xu5vUpIL44ItcMUpGn
	 IUrtjUIcE6BFKd5M/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1xI5Sn27Ky-002F4v; Wed, 11
 Nov 2026 00:22:21 +0100
Message-ID: <9c9c2335-f1b7-4f17-b491-2403955bec8c@gmx.de>
Date: Wed, 11 Nov 2026 00:22:18 +0100
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
Subject: Re: [PATCH V3 RESEND] fbcon: Avoid cancel_delayed_work_sync() in
 atomic context
To: Yao Yiqi <yyaqia@gmail.com>, tzimmermann@suse.de, simona@ffwll.ch
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yao Yiqi <yaoyiqi3@huawei.com>, stable@vger.kernel.org
References: <20261110135959.232798-1-yyaqia@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261110135959.232798-1-yyaqia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ko7hN4jifQKCE4StcvCty4o0UfCy2iJXLMuvp/3/F9n+A/mEr++
 Q2Wx5xuBCo4DrXeDpqmK1/oVf6F8BzbZN2Bn9wsEEV9Pq8A/6E/HqUQJIZ6Q0UAr/diC7r0
 70Qm1htq7VeoWct6TnAPbFK/xQPK4DgGwVTwiH/NGeG2Oq4EoheNxotf2RYewcWhDO3vhWa
 9nQTzeT52JBQ22jJhGv/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bUICXfadXIk=;uaqO4c9wENSOWfJpJw6Z5dPw4y4
 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
 rNSuRTq1c+/0yM

On 11/10/26 14:59, Yao Yiqi wrote:
> From: Yao Yiqi <yaoyiqi3@huawei.com>
>=20
> fbcon_cursor() can be reached from the console printing path, which runs
> in atomic context. When the VT software cursor is enabled
> (vc_cursor_type & CUR_SW), it calls fbcon_del_cursor_work(), which uses
> cancel_delayed_work_sync() and therefore may sleep.
>=20
> With CONFIG_DEBUG_ATOMIC_SLEEP enabled, the following is reported:
>=20
>    BUG: sleeping function called from invalid context at kernel/workqueu=
e.c:4722
>    in_atomic(): 1, irqs_disabled(): 1, non_block: 0
>    ...
>    __cancel_work_sync
>    fbcon_del_cursor_work
>    fbcon_cursor
>    hide_cursor
>    vt_console_print
>    console_unlock
>    ...
>=20
> Make the default helper safe: fbcon_del_cursor_work() only stops
> blinking, using cancel_delayed_work(), which is allowed in any context.
> Every "stop blinking" call site keeps using it, including fbcon_cursor()=
.
> Only fbcon_release(), which is about to free @par and must ensure that n=
o
> callback is still using it, calls the separate
> fbcon_del_cursor_work_sync(). New call sites therefore get the safe
> variant by default.
>=20
> cancel_delayed_work() does not wait for a callback that is already
> running. Since fb_flashcursor() re-arms itself, a callback that has
> already been dequeued by process_one_work() can queue the work again
> after fbcon_del_cursor_work() returns. Add a cursor_blink_on flag to
> struct fbcon_par: fbcon_add_cursor_work() sets it, fbcon_del_cursor_work=
()
> clears it, and fb_flashcursor() checks it after taking console_lock and
> returns without drawing or re-arming once blinking has been stopped.
> Keep the requeue inside the console_lock section so that the flag check
> and the requeue are not split by a concurrent stop.
>=20
> Fixes: 3b0fb6ab25dd ("fbcon: Use delayed work for cursor")
> Cc: stable@vger.kernel.org
> Assisted-by: Opencode:deepseek-v4.1-flash
> Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
> ---
>   drivers/video/fbdev/core/fbcon.c | 41 +++++++++++++++++++++++++++-----
>   drivers/video/fbdev/core/fbcon.h |  1 +
>   2 files changed, 36 insertions(+), 6 deletions(-)
applied to fbdev git tree for further testing...

Thanks!
Helge
