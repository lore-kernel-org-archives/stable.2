Received: from coelho.fi (coelho.fi [88.99.146.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0AC3BA22C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.146.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033860; cv=none; b=ilPiM0RqtlOehzZLYx1lIKAnhTyYY7lqKRUpjZLWjNRBbusTrW3UBYuVx6AFATak2wcJjq5nbQX7PKHFSzpXrortrlWiQSbzTDv/EzTmryWpHuVKvjXBVhx8NK6zXYFjKRm+8N5+2S5LSPnXeddHZL/eQ1C5IhOg33Q4oP7Chn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033860; c=relaxed/simple;
	bh=D0KEYfwZt07sAUT5k16wmBFw89fRPkUEQ5i/fGlewaE=;
	h=Message-ID:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Subject; b=q1tHMI5WM5ZiAO160saz7jbZ0ujPyqVAEcpAgTwOysBLv8Ravy9mge9mznTq7ponNYVAd7MjU3MuOpKaeWukjDkdpOzZxga+DIdAo7vh7ELC0nWEm/nDlegKqZtF8/GDWAKpeigKt+cY4oBW1t4E9ex6p+v5rElXfHSOjfVbkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi; spf=pass smtp.mailfrom=coelho.fi; arc=none smtp.client-ip=88.99.146.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelho.fi
Received: from 91-158-54-113.elisa-laajakaista.fi ([91.158.54.113] helo=[192.168.100.133])
	by coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <luca@coelho.fi>)
	id 1x4b8A-00000003PbM-0WnI;
	Thu, 10 Sep 2026 12:31:44 +0300
Message-ID: <00613437ad4aacce854eb2c095308a2f0d7dd119.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Date: Thu, 10 Sep 2026 12:31:38 +0300
In-Reply-To: <20260907174413.741851-1-imre.deak@intel.com>
References: <20260907174413.741851-1-imre.deak@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
Subject: Re: [PATCH 1/2] drm/i915/dp_mst: Fix configuring FEC for a
 disconnected stream

On Mon, 2026-09-07 at 20:44 +0300, Imre Deak wrote:
> During an atomic commit after all the MST stream CRTC state is computed
> the driver ensures that the FEC is configured the same way (enabled or
> disabled) for all the streams on a given MST topology's link.
> drm_dp_mst_port_downstream_of_parent() used to determine if a stream is
> downstream of an MST port will return false if the whole topology is
> disconnected, since in that case it can't verify that the port/
> parent_port passed to it is in the given MST topology. This is a problem
> during the above FEC configuration check, since
> intel_dp_mst_check_dsc_change()->get_pipes_downstream_of_mst_ports()
> will not return all the stream CRTCs/pipes for the topology as expected.
> Since passing parent_port=3D=3DNULL to get_pipes_downstream_of_mst_port()
> is meant to return all the streams for the given topology (i.e. mst_mgr)
> skip checking if an MST port is downstream of a parent port in this
> case.
>=20
> This fixes a problem where the FEC configuration check explained above
> failed to ensure that all streams' FEC is configured the same way if the
> topology was disconnected, leading to a FEC state mismatch error.
>=20
> Cc: stable@vger.kernel.org # v6.10+
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
> index 6a869d0f6ffc0..20766b6c0bcfa 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -856,7 +856,8 @@ static u8 get_pipes_downstream_of_mst_port(struct int=
el_atomic_state *state,
>  		if (&connector->mst.dp->mst.mgr !=3D mst_mgr)
>  			continue;
> =20
> -		if (connector->mst.port !=3D parent_port &&
> +		if (parent_port &&
> +		    connector->mst.port !=3D parent_port &&
>  		    !drm_dp_mst_port_downstream_of_parent(mst_mgr,
>  							  connector->mst.port,
>  							  parent_port))

Reviewed-by: Luca Coelho <luciano.coelho@intel.com>

--
Cheers,
Luca.
