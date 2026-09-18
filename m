Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E363493D57;
	Fri, 18 Sep 2026 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758965; cv=none; b=BGrXeN/cXJtLo25OoCzcx7s0W0Sie7EZpJAp/Ph7064tPiTxQlp2jja8o15X1FfX0KiuTddWPCi/djjkZ6fXC+CExG7UVgMmVZtIVxibzZTwJXYECVoIiJpin5MqRKMWk3DUeU0kjwKKgpElwO5D/jZhNGPcsIC1025uXeGyA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758965; c=relaxed/simple;
	bh=02Tc3qN4e2T7uvZ8T6wuZ3F3SvaD4Aa6PB7Tar/GMWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQybX5cvJoN8iiZbEeWn2Tfk7AdGSfiyIGR98fSaqLJhDGvjHl4RdrbXSpzhRuArA6onfby/H9pHF29h4/ixbWqZKQddMud8sAJ7FzvDv5cTZUwH1Wfy2eZ6Pe3kpj3JeLIjYD3NuZSorIomjSMDb/dTBL19ArnWhw6UFztNqNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKw6sfhq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKw6sfhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71C01F000FF;
	Fri, 18 Sep 2026 19:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789758957;
	bh=c8IYTH9i4dCWQ3YBYlg4BiRyNyAFEn5b5sEjDutkcG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YKw6sfhqahSo98FQ4YDH83GDubZmslsBOzCwRX5YmDgRq4HgmZJeuxuuLlj7Wn12F
	 JIG9OZfecc0o4NNUKdBwXgChQhS5qOW5SdJLY5S/tVMCBbxqGzDuUYl3TxbWLC4EWy
	 gUwN/Y4EcNvvttHTWMxLeq+kzDOwANwRuOCT/6YcFyJh6UdAjROaC9kgfsRGBH8KH+
	 A4JafannxaoNil5bz7YTyuzn0Hju8miNiJ13qxM+0cR67wm7FhxSZFInUOc9moQ2PD
	 81EZNkvRtpWmJJtckhzdjUremJPwG4eaSA0hyhPDyp97TmxvhDFVwX9xBfBgsD8hcd
	 GD22mktcJix5g==
Date: Fri, 18 Sep 2026 12:15:56 -0700
From: Oliver Upton <oupton@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Yuchao Zhang <ndaugoing@gmail.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: vgic: Do not remove in-flight LPIs from
 AP list on disable
Message-ID: <aq2N7HYbQw7zbpCq@kernel.org>
References: <20260918040214.85580-1-ndaugoing@gmail.com>
 <20260918040214.85580-2-ndaugoing@gmail.com>
 <CA+EHjTx8zzvgqj99TKWfRD58X-M8v+hs9358_r_1zZonFNEsgw@mail.gmail.com>
 <CAC2BP3K-fvW2s2j2ys+kPMuxrzeMw9yc6MrAk7U7CqCpb2WePQ@mail.gmail.com>
 <CA+EHjTx9bTDuTnGgkrCcaAG+1S1Lx6+1BZnuhJcWNTJxWXkAHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTx9bTDuTnGgkrCcaAG+1S1Lx6+1BZnuhJcWNTJxWXkAHw@mail.gmail.com>

On Fri, Sep 18, 2026 at 12:58:17PM +0100, Fuad Tabba wrote:
> Hi Yuchao,
> 
> On Fri, 18 Sept 2026 at 12:51, Yuchao Zhang <ndaugoing@gmail.com> wrote:
> >
> > Hi Fuad,
> >
> > Thanks a lot for pointing me to that thread! I was not aware of
> > Hyunwoo's earlier report and the discussion with Oliver and Marc.
> >
> > I'll read through the thread and their rationale on the ap_list_lock
> > approach. I'm happy to defer to Hyunwoo's effort to avoid duplicate
> > work.
> 
> I'm not sure you should defer to their effort. It doesn't seem like
> Hyunwoo has done any work on this for a while. I just wanted to point
> you to the existing discussion.

Yuchao if you have cycles I would definitely appreciate it if you can
pursue a fix. My view hasn't changed since before: let's make that
traversal of the ap_list is done under the ap_list_lock, as this is not
intended to be walked lock-free.

Taking a step back, the whole cross-vCPU LPI disabling always leaves me
feeling ill... Really when RWP=0 becomes visible from another vCPU we
need to guarantee that the LPIs have been actually retired, meaning we
can't have one sitting in an LR. Even with the locking fix I think we
miss this.

Given how unlikely it is for well-behaved software to disable LPIs
remotely in the first place, I wonder if we should just halt the VM
similar to how we handle accesses to the active state. That's a really
big hammer but we've had a lot of bugs in this department and I'm
somewhat biased towards an obviously correct solution.

We wouldn't need to do this for a vCPU disabling LPIs on its own
redistributor since we've already exited the guest.

I'll think on it a bit more.

Oliver
