Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25CA438499
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226971; cv=none; b=m581V1HNupIU/Y7Eh2kM2+NYORW3j+Vp1FThmkn2eqkuk6yNHSoWHYEv2ABugWCphBt4qtXfjqoCY/luHGKJiyIqAezWwkxJ6wX0tSc9djRT+2TxhX83a02VWSLkGctO2RGJVjauD0IbVw30BppUINKI/wYyRKiLQ2YeAHnXLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226971; c=relaxed/simple;
	bh=+MPI93qkv61lBSPD//o9tWxpG96jk9/koJb/RJZfIOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkQzMOIFToU1/YFk3RmoyKO5pPo3X+RstKH5PbqZqSxhT6jhvPuBLYplyj6qepnKHezpCuZfbltbqVV7f62N9U0p0BgMQZDNrmw4NRmJ5i5ecbgBT378NobU5EkzUFx2bXDDMbeoBMVb+FxWUCCpCfFp1F/AuOFEkU+WMB9o0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pGvgFuVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pGvgFuVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59991F000E9;
	Thu, 20 Aug 2026 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787226969;
	bh=mMzy8YyYtTvff6kpymo99efnbj47qtOq/N10+DSbdGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pGvgFuVSqtvyFKB3IecaAgzzOJmVFgMkxyA4dWX4ENXBQhbmG1VjnvgtnAhIkJ+Ze
	 8iijFQKTDUac37ZcGlO1rGSfrtsybAye5bvAwuPg+T3i9iUT+QCtHtJQ6Jv9kS9xeO
	 C2TdchVAhrHuw0dAo23ukL+0RXT/X09eceV7s7GI=
Date: Thu, 20 Aug 2026 13:49:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: broonie@kernel.org, kai.vehmanen@linux.intel.com,
	liam.r.girdwood@intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ASoC: SOF: ipc4-topology: Refresh copier
 IPC payload before" failed to apply to 7.1-stable tree
Message-ID: <2026082057-sulfite-daunting-34da@gregkh>
References: <2026082016-frisk-riches-3e59@gregkh>
 <1142f719-4f26-4a2f-be99-af4822cd78b1@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1142f719-4f26-4a2f-be99-af4822cd78b1@linux.intel.com>

On Thu, Aug 20, 2026 at 02:45:30PM +0300, Péter Ujfalusi wrote:
> 
> 
> On 20/08/2026 14:06, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 7.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 0c0e418dbcf0582bf80d8dbfd9b306607c065992
> > # <resolve conflicts, build, test, etc.>
> 
> I'm not sure what might be the issue, but it is clean here:
> HEAD ffc82ed66531 tag: v7.1.9, Linux 7.1.9
> 
> git cherry-pick -x 0c0e418dbcf0582bf80d8dbfd9b306607c065992
> Auto-merging sound/soc/sof/ipc4-topology.c
> [peter/upstream/host-copier-refresh-7.1 ffe9d6156740] ASoC: SOF: ipc4-topology: Refresh copier IPC payload before widget setup
>  Date: Thu Jul 30 08:48:22 2026 +0300
>  1 file changed, 33 insertions(+)
> 
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082016-frisk-riches-3e59@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'
> 
> Since there are no conflicts to resolve, should I still send the patch?

I see major conflicts here:

Applying patch asoc-sof-ipc4-topology-refresh-copier-ipc-payload-before-widget-setup.patch
patching file sound/soc/sof/ipc4-topology.c
Hunk #1 succeeded at 3167 (offset -37 lines).
Hunk #2 FAILED at 3221.
Hunk #3 FAILED at 3229.
2 out of 3 hunks FAILED -- rejects in file sound/soc/sof/ipc4-topology.c
Patch asoc-sof-ipc4-topology-refresh-copier-ipc-payload-before-widget-setup.patch does not apply (enforce with -f)

thanks,

greg k-h
