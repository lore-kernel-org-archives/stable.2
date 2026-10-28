Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197632;
	b=DfISGwH4pmjrgOatoUe/dsY+gzmuSWGg2v53McRSzIyzVghw3l1rwqfEebc7SDtUi4rz
	 TS7RE4+VC2vUGvgddu4Lqmc7kdGFELGXgSiDvJXAPc4A14BdIhGPSkD6M7gd7j5BnpIa/
	 TPBxy1SHtb82CEI7Z+gXef0MmrCnXtQP0yc/Ztr6Zpa/3P80KOpeCMP9c2YAEcuJ9j5RF
	 +c600n/onvan4xDSfFr1KZV651HZa+bEflAaJHk26cnyGgTfcvpaDG8vd7DQaYXvuYlJj
	 8p969C9r+BO9HBVU2qEvcX+tILy56kDf3QT9A8unC9ZIUWuMkqihdvSd+o3RXog4jaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197632;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=RyRP6893UE0rWEYYIRvTbvq1/0IgRI1V3wsjtlSLgFI=;
	b=25/4XL5N4yLCq8AqY/wWMKtcRUg8OwN/CAfwc+K3qpcezJhcIfPW0j7VQRIObVVqtALh
	 DmAXlVw/5zUG2nhUEwjylu7eBHXrLuzcNM6/Dx2Z6Ls+KfILrmtLwOM9bPZA4q+bAi7BA
	 J4SzEgNIZXjw3dhF40Pft/XDv/t2rpqeXaY9Tec486Q+8ODfonyYv00LyTvFfnqWjMLtW
	 Z9XuXAyKnlX/vRbTKkqrpQFihWx4cY5SkbQbl0F+o57jLEbkFflRu1FRPKBxaJZhZpUeL
	 wgRVies0STwuPaWmMiuE3/U1ELtVtpQB163n7kn0DJuEMLmSpxH5i1ICXabauoJ+TvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVjCA6Re;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7A606A31A;
	Wed, 28 Oct 2026 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVjCA6Re
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D44A1F01825;
	Wed, 28 Oct 2026 14:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197631;
	bh=RyRP6893UE0rWEYYIRvTbvq1/0IgRI1V3wsjtlSLgFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JVjCA6ReIrVf7NJxWt1lAJnRIz+lL/HaaUx8lFRg83tHXp4nIFupZjZZRpkVrHnj/
	 qxcZwyqwqGMm536IG/3e0q5weJ26ikgncaPhxQm/0bg8UnN1gmW6n33+VCJ+bdWV0s
	 KS11A2WBLjKk5JBVUpBsFIqB4vbQmew7x2R6OLOS9QDQ690pMLfI1fqcd+Uvl8jvdD
	 wwLUOJ97nys0BM+VWwwecp/SVB4ruqkAcITsPs1Bdu4wmN2wRzon4ikOsUQThehaxU
	 bfiCIudRV/xW1e+jtnq/Kgbppz8FbdnJOn6nevTKDXYi++VBWPp26AK2rMEgQmyL35
	 6NvOiml9NyAAQ==
Date: Wed, 28 Oct 2026 14:27:06 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, owen@verialabs.com, jiri@resnulli.us,
	victor@mojatatu.com, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net/sched: sch_teql: fix use-after-free on
 lower qdisc drop
Message-ID: <20261028142706.GV257209@horms.kernel.org>
References: <QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com>
 <20261027182608.448075-1-horms@kernel.org>
 <CAM0EoM=53FJSOSFzO6sPuHqDi4wxNPxK_mYRBveUz_Y6ks9swg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=53FJSOSFzO6sPuHqDi4wxNPxK_mYRBveUz_Y6ks9swg@mail.gmail.com>

On Tue, Oct 27, 2026 at 05:19:26PM -0400, Jamal Hadi Salim wrote:
> On Tue, Oct 27, 2026 at 2:29 PM Simon Horman <horms@kernel.org> wrote:
> >
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-Y0BY.v2.r0.20261024060625-1@mojatatu.com?part=2
> 
> So this email was stuck at sashiko because the email fields wouldnt
> allow it. Set at:
> email_status: Muted, smtp_enabled: false
> The same with patch 2/2

Fun times in AI-land.

> I will respond to both here. Summary is: i will not be sending an update.
> 
> For patch [1/2] net/sched: sch_teql: fix slaves_lock IRQ deadlock
> The High is pre-existing and not introduced by this patch, which only
> converts slaves_lock to a raw spinlock.
> I have a separate fix that bounds the walk by a slave_count maintained
> under slaves_lock; it will be posted after this  series gets merged.
> 
> Patch [2/2] net/sched: sch_teql: fix use-after-free on lower qdisc drop:
> 
> 1) Low: agreed, the changelog is misleading (the code is intended as written).
> NETDEV_TX_OK and NET_XMIT_CN are both counted as good transmits,
> matching  net_xmit_eval(); any other consumed result is charged to
> tx_dropped.
> I don't think it warrants a respin on its own unless something even
> semi-serious shows up in the code.
> 
> 2) Medium: the non-rotation is pre-existing.  Before this patch the
> drop path never advanced master->slaves either; it just retried the
> freed skb, which is the use-after-free being fixed.
> Advancing to NEXT_SLAVE(q) here is a  load-distribution improvement,
> not a correctness requirement of this fix.
>  IMO:   I would rather not inclued a policy change into the UAF fix; I
> can send it  separately.

Thanks for the feedback.
I agree with your suggested approaches.

Reviewed-by: Simon Horman <horms@kernel.org>

