Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3C397942;
	Fri, 18 Sep 2026 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695791; cv=none; b=P13dRin0ZY5uGxkPc3eslQOtUxbRFBhgIGQlSOWSIWxZ4ZsZ+OEOvVrIHtxCoVl4xlRoh8EUt7QOD7PXIXSzrxl9wt/Hj7rvwJdDKfMK76dX6ificANn8NAvaXHhhpyoemOUqQm+NSOPbd9REBB8LJ2yYxXo24+mMt5CWp/idsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695791; c=relaxed/simple;
	bh=0QrKtCdUouZWwbmAn+XLAoZlUwCYU5IPuvFhlx5OqlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWNwQAHT5SGv4mN1XN38XqaPjn097ynrCutaormOjZEzd4eB44yDf6Zgi+I1Ia7OXCWg9zi31De3TPyAYwzvNn6DVkCll1GawLhS3sdx5WSqtENwVLvM7D/VXxCWqeoOnNistY6Cv328OYZJ0wdavYXNlaotz9tuTTl5z26dkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6RqC20m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6RqC20m"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6482C1F000FF;
	Fri, 18 Sep 2026 01:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789695790;
	bh=dofvagGQeEInWWYgb/YqczbGV/3rzAsbrfnScLnrygI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g6RqC20mPLaL28EGOKbp9Ip2RABYku3mIEnhl+ZPhJF/qdj8+/dpOg5Ucn5f7GWTG
	 87h3J3zbkd/hlmREgtuDMVDOH3DLZyg395lRQGSzF4MFfgx9MXCQUajIoOLFVJO2Ry
	 sVVz3fRhE0xeg592LjbmIWY23uhIbW2wn2CHqw/QJ/lomPbE26QMMY5KoLCg0PpVgj
	 yqn7yUuoC2rrNZDjMBiD5+3zjaccWkd5zooL/WPdR5VqOX0PG2p7XAwysBMXuppbWf
	 cgQ8cbRz3J25E3sOEg7XFDbRAxjDR2GJNHGai3Eyr+0ny+mtHdjY4PnBc+fa/oeWXv
	 GR9KCiPJ/DvFw==
Date: Fri, 18 Sep 2026 04:43:06 +0300
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
Message-ID: <aqyXKrC4hhFP1mEd@kernel.org>
References: <20260901205809.2028454-1-jarkko@kernel.org>
 <apfoKo-BdwaLXtkT@sgarzare-redhat>
 <aqHIwoKcEWeI_yjs@kernel.org>
 <aqJhkjPdib-MQTCT@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqJhkjPdib-MQTCT@sgarzare-redhat>

On Thu, Sep 10, 2026 at 09:52:38AM +0200, Stefano Garzarella wrote:
> On Wed, Sep 09, 2026 at 11:59:46PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Sep 02, 2026 at 11:24:16AM +0200, Stefano Garzarella wrote:
> > > On Tue, Sep 01, 2026 at 11:58:06PM +0300, Jarkko Sakkinen wrote:
> > > > tpm2_load_cmd() does boundary checks against the ASN.1 size i.e.,
> > > > payload->blob_len. Address this by passing the decoded blob size to
> > > > tpm2_load_cmd(), and use it for the boundary checks.
> > > >
> > > > Cc: stable@vger.kernel.org # v5.13+
> > > > Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> > > > Reported-by: co+6a581c4284f721d4@bugs.sh
> > > > Closes: https://bugs.sh/b/6a581c4284f721d4/
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > > security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++-----
> > > > 1 file changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > > > index 67225dd562a9..01f18bb37047 100644
> > > > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > > > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > > > @@ -99,7 +99,7 @@ struct tpm2_key_context {
> > > >
> > > > static int tpm2_key_decode(struct trusted_key_payload *payload,
> > > > 			   struct trusted_key_options *options,
> > > > -			   u8 **buf)
> > > > +			   u8 **buf, unsigned int *blob_len)
> > > > {
> > > > 	int ret;
> > > > 	struct tpm2_key_context ctx;
> > > > @@ -120,6 +120,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
> > > 
> > > 	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> > > 
> > > Pre-existing, but is `+ 4` here useless?
> > 
> > I checked this through in detail.
> > 
> > It should not be like that given that callbacks tpm2_key_{pub,priv}
> > provide the length of TPM2B_PUBLIC and TPM2B_PRIVATE.
> > 
> > Thus, it is a bug introduced by f2219745250f ("security: keys: trusted:
> > use ASN.1 TPM2 key format for the blobs")
> 
> Yep, agree. Do you want me to send a fix?

Sure, go ahead.

> Thanks,
> Stefano

BR, Jarkko
