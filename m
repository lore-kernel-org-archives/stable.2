Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684616;
	b=PSyZ+IlOkT27sxidIOn2fVu9WWZeZnKNqsvDqqK5WKQAlKZb+cpDkYYLX0o4YCc85ElD
	 Wg3VPkjYmUtnbL4gtz58GNQcYD+v11V74e/2JJ3iDLdqQscqz5GPx9i6NNzCf531wd4ds
	 Hi1dfXJR3xgikg+A7TrLC6AA/JiUL6PF67QMPQf57fyGSQsdKZvG8IE1axuMuUZUlo68W
	 xaJZ5+NLe4DHaUDZE3MLeSnOcFS84Jb4dyTeEp1KGw4PW7Uy15FOQZorRPIy6IGeyS+pt
	 TFGxFZQHWQdSIZev/NRyOxPcH9oNDAAS40KHnX7BooR1dNaz5j2hv0pqTuI211tR8AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684616;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZfdcZ48c//AzqVH7rKfuc7GAHFokrDENxga69K9MVf0=;
	b=gRM91y3QG+9FIFiwZaujwvirlaPHAXUEuICgqPwaO0pFSJLi/5aG5twdYYxnKMxDzWMK
	 2acTiwzKQG9wJXgNus33ad42GHVfRxuXxfFHiGkvhKbpzYwvXrC2gsRBxC5N3scQ07QGV
	 XwAs8N8q43foJUfYO5oND2drMqxF6DNG/1zh6md+irlhbJkqNJCOKlw3r/9XMpmhY7zds
	 wC2JbgmZdAuHSUtr8W2fntViu50v/btPKj0C4hoqpbTC2slgHgHLK+HISp7UGIGmsXdgf
	 v9bA4+APKPwK65623Yy8HlyCbCwUCOYLXJaCTmVH2EyQVDiJnUJEvhkUSNOVVyFXH+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXi4jtdy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12F606A31C;
	Thu, 26 Nov 2026 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXi4jtdy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A801F000C4;
	Thu, 26 Nov 2026 09:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795684616;
	bh=ZfdcZ48c//AzqVH7rKfuc7GAHFokrDENxga69K9MVf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MXi4jtdyxHYxeNd9GvD8/qTFBek+uKD/UwQvdkBGMpRoBOKugRg1mH/Sgv8frDoTk
	 W0hwp50y+gziYVZkt41i99BFLSJEup8+HwVZwkJ1tsunz+k4Hug8CfwibkTj4EgYov
	 eHcq8Hi0MJdTD47i1JQs3SnmqQot035w4Rl0yQ6OpcKs0MpS8qCPBRvCSiQr0LJ15J
	 vQvkWgMepbe6g9vBPRrN9ZbMDxbMh85D7+o7r9bErMGnarnZWdbHZpEM3e1zPeWw12
	 7ctXM5s0ZmPEQCTuwt3euxOfFxj7lfoy2SH9D0UQaQUyJHWcQ/tP3CXyL7YWeuXhyj
	 EMlp5ct0ly5Hw==
Message-ID: <534f7330-d4de-47a8-ba6b-68c29c138186@kernel.org>
Date: Thu, 26 Nov 2026 09:16:53 +0000
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
Subject: Re: [PATCH v2] soundwire: qcom: Fix off-by-one error in port
 exhaustion check
To: Christopher Obbard <chris.obbard@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261126-wip-obbardc-soundwire-qcom-fix-port-off-by-one-v2-1-c424edf85968@oss.qualcomm.com>
From: Srinivas Kandagatla <srini@kernel.org>
Content-Language: en-US
In-Reply-To: <20261126-wip-obbardc-soundwire-qcom-fix-port-off-by-one-v2-1-c424edf85968@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/26 8:56 AM, Christopher Obbard wrote:
> Qualcomm SoundWire master ports are indexed from 1, with bit 0 of
> port_mask reserved. Valid port numbers therefore range from 1 to
> maxport.
> 
> Commit 6ccec91c3535 ("soundwire: qcom: Fix port exhaustion check in
> stream_alloc_ports") changed the port exhaustion check from
> pn > maxport to pn >= maxport which rejects the last valid port.
> 
> On RB3gen2 (QCS6490), two WSA883x speaker amplifiers are connected
> to swr2, which has qcom,dout-ports = <6> and qcom,din-ports = <2>
> (8 ports). Each amplifier uses one port for playback and another for
> voltage and current sensing (VISENSE). The right amplifier's
> qcom,port-mapping is <4 5 6 8>, so its VISENSE port is master port 8,
> which is rejected by the new check.
> 
> Since all ports in a SoundWire stream are allocated together during
> hw_params, this causes the stream to fail with:
> 
>     qcom-soundwire 3250000.soundwire: All ports busy
> 
> The -EBUSY propagates through hw_params, preventing speaker playback.
> Disabling VISENSE works around the issue. Speaker protection is not
> enabled on this device in upstream, but with AudioReach userspace the
> userspace PAL mixer paths enable VISENSE on every speaker stream, so a
> mixer change alone does not avoid the failure.
> 
> The original fix addressed an exhaustion check that could never
> trigger because find_first_zero_bit() returns maxport when all
> searched bits are set. Include the reserved bit 0 in the search so
> exhaustion returns maxport + 1 and restore the pn > maxport check.
> 
> Tested on RB3gen2 with a v7.4-rc3 based kernel and AudioReach
> userspace: with the stock PAL mixer paths, which enable VISENSE on
> both amplifiers, speaker playback through the PAL speaker sink is
> audible and no longer fails with "All ports busy".
> 
> Fixes: 6ccec91c3535 ("soundwire: qcom: Fix port exhaustion check in stream_alloc_ports")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christopher Obbard <chris.obbard@oss.qualcomm.com>
lgtm,

Reviewed-by: Srinivas Kandagatla<srinivas.kandagatla@oss.qualcomm.com>

--Srini
> ---
> Changes in v2:
> - Rebase onto soundwire/next.
> - soundwire/next now has commit d9ea256ee889 ("soundwire: qcom: Prevent
>   pconfig buffer overflow in qcom_swrm_stream_alloc_ports()"), which
>   adds an nports >= maxport bound on the pconfig array. That bound is
>   separate from the off-by-one fixed here: it keeps pn >= maxport, so
>   the last valid master port (maxport) is still rejected and RB3gen2
>   speaker playback with VISENSE still fails with "All ports busy". This
>   patch is still needed; keep both checks as
>   pn > maxport || nports >= maxport.
> - Add Cc: stable@vger.kernel.org, as 6ccec91c3535 landed in v7.3 and
>   was backported to stable (Srini).
> - Drop the claim that disabling VISENSE disables speaker protection;
>   speaker protection is not enabled on any upstream device (Srini).
> - Give the concrete swr2 port counts and the right WSA883x
>   qcom,port-mapping from the RB3gen2 DT.
> - Note that the PAL mixer paths enable VISENSE on every speaker
>   stream, so a mixer change alone does not work around the issue.
> - Add a note about testing on RB3gen2.
> - Say the -EBUSY propagates through hw_params rather than naming the
>   codec DMA backend.
> - Link to v1: https://patch.msgid.link/20261012-wip-obbardc-soundwire-qcom-fix-port-off-by-one-v1-1-81f1a4c9c73a@oss.qualcomm.com
> ---
>  drivers/soundwire/qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 65add9a74ffd9..05311cf639e4c 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1461,9 +1461,9 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>  				if (m_port)
>  					pn = m_port;
>  				else
> -					pn = find_first_zero_bit(port_mask, maxport);
> +					pn = find_first_zero_bit(port_mask, maxport + 1);
>  
> -				if (pn >= maxport || nports >= maxport) {
> +				if (pn > maxport || nports >= maxport) {
>  					dev_err(ctrl->dev, "All ports busy\n");
>  					*port_mask &= ~allocated;
>  					return -EBUSY;
> 
> ---
> base-commit: d9ea256ee889f3db9f0bd07ce5d114ce92e31b4f
> change-id: 20261012-wip-obbardc-soundwire-qcom-fix-port-off-by-one-47c0a8af1c5e
> 
> Best regards,
> --  
> Christopher Obbard
> 

