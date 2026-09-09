Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95C472527;
	Wed,  9 Sep 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987595; cv=none; b=l2UPbEIl9Yd594Vi+DxlXuCdA/3AnbhitMVFTvKj8fk511i8/8lKqvjQh5igMtOiF2z1BOu3CBTPduplEekseeF6KsTRRpM9rm9icHH67FdwD7X+JQYlXG/0CZiJR+UgQJ0UdhVzKv2T6+DGTDBuE3JplKH+H+oqRK4U2VwWsQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987595; c=relaxed/simple;
	bh=TCPF788yJbKT1QO3eQTw1r25ed/2NjUf5oMOCcUlklE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs8T9imlwN2hCMvOkW2NOpX6L/wCVLm5NVQ2nAA4IORUI8qIUrBrZDywtEs59lq1smlSugbVMFu/CY9YvPjTZMmFKnEWHYVtcbn2MAcM4wQShddN6VFEg45/LM8J1divZc9Ze/dcgBGV8tPwAyUpY2skIpyopBO500pBy2MHEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTygoM5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTygoM5o"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2345F1F000FF;
	Wed,  9 Sep 2026 20:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987590;
	bh=LjNmOGcLXgxwQzVfCFuc8t0g6g8wY2tPXp0eEeomkA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hTygoM5oLzrNynZ+zO06f5DN4bvliWumj5Z9tqJ0dEFndANXVqxPcAEvKMiLAll+v
	 bZ2sK7CuUxxK4Xo507vH/rt8GmE5+0HyQYDpDonWf0EdOgdrRWW6X3pb7lGtRkluya
	 hrRCzyS5Zi/h7BP07ChyDRCeQ5vk/bgD/MZnAbblGfVDT8oGGbcfmETgKhKUzCNZTd
	 kwaKZnVXicpRS2f+/ylxY0z2zOK+8/eT6nsQRzW4hot+koc1nxE+XMK54waOGqamPL
	 8QoTV3Rpw+PDnjUQwmonAByb4yAi/iIPITfHEl5xsOxZAEIY7VgtB76fllrx+2vRM6
	 u9CG59MZ5tdvg==
Date: Wed, 9 Sep 2026 23:59:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org,
	co+6a581c4284f721d4@bugs.sh,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan McDowell <noodles@meta.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Srish Srinivasan <ssrish@linux.ibm.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: Fix tpm2_load_cmd() boundary check
Message-ID: <aqHIwoKcEWeI_yjs@kernel.org>
References: <20260901205809.2028454-1-jarkko@kernel.org>
 <apfoKo-BdwaLXtkT@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apfoKo-BdwaLXtkT@sgarzare-redhat>

On Wed, Sep 02, 2026 at 11:24:16AM +0200, Stefano Garzarella wrote:
> On Tue, Sep 01, 2026 at 11:58:06PM +0300, Jarkko Sakkinen wrote:
> > tpm2_load_cmd() does boundary checks against the ASN.1 size i.e.,
> > payload->blob_len. Address this by passing the decoded blob size to
> > tpm2_load_cmd(), and use it for the boundary checks.
> > 
> > Cc: stable@vger.kernel.org # v5.13+
> > Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> > Reported-by: co+6a581c4284f721d4@bugs.sh
> > Closes: https://bugs.sh/b/6a581c4284f721d4/
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++-----
> > 1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > index 67225dd562a9..01f18bb37047 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -99,7 +99,7 @@ struct tpm2_key_context {
> > 
> > static int tpm2_key_decode(struct trusted_key_payload *payload,
> > 			   struct trusted_key_options *options,
> > -			   u8 **buf)
> > +			   u8 **buf, unsigned int *blob_len)
> > {
> > 	int ret;
> > 	struct tpm2_key_context ctx;
> > @@ -120,6 +120,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
> 
> 	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> 
> Pre-existing, but is `+ 4` here useless?

I checked this through in detail.

It should not be like that given that callbacks tpm2_key_{pub,priv}
provide the length of TPM2B_PUBLIC and TPM2B_PRIVATE.

Thus, it is a bug introduced by f2219745250f ("security: keys: trusted:
use ASN.1 TPM2 key format for the blobs")

BR, Jarkko

