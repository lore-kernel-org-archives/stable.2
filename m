Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368553DA5C3
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026776; cv=none; b=DgYEXtTAn4jq/iXWwaMEvWrlsxQf0Pi7hjursJh7wsillIl6Hpbn/t3fiA2ySfo/xqNzwE4obCw5nAcXElK566rKrDMR17YIEeW4xEZC3tbweDapaLlge6+8KdLESV7npFbMMoxTbOQFv4JQM/HQqspi1GphTt7NC1okPi5kaIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026776; c=relaxed/simple;
	bh=CsLIGHHO8YWAldmY8Naazy7NOx7PZIBpEJmR+iBDvqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJp09+hrkWRiGTRAbrMpXOzGZKx37kR+roVS66IUs1d5OgcHV1XlgONplXi2XcAJ2NqM1Rr87ciLKUKVy1j/LKMOCV+yb5A9iDfXVLwAKoNPKcuJPY8JLPaEgih0FRzv2SP5d51IKz/v2kmtfpPQqhRtD1nVqSgG1j/b4guZ0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj7oyrmZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUMZe1gp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj7oyrmZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUMZe1gp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789026774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zdat3lb+JFaceCjEvZhP3kP5xpKa4RbvpVHW8sS2v0=;
	b=Bj7oyrmZVR9i5l09nENsd3Ehvh1j3A2xi86XHNxDhT2mXfcs28L+dK0JMaxFshMm+uMCQc
	fz6AHrQiwN9Xhrs5sCE+zujaXCYbysPtvW7J6lc57gJpca2oQK99xiD0i0ePdB2B0WUr1N
	tsTj5H6qdt7jIgjOS1H8BnCmJLCX6h8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-UCQDa0X-P3GN-o5tbewGGg-1; Thu, 10 Sep 2026 03:52:53 -0400
X-MC-Unique: UCQDa0X-P3GN-o5tbewGGg-1
X-Mimecast-MFC-AGG-ID: UCQDa0X-P3GN-o5tbewGGg_1789026772
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso67982205e9.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789026772; x=1789631572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3zdat3lb+JFaceCjEvZhP3kP5xpKa4RbvpVHW8sS2v0=;
        b=aUMZe1gphFpGyWH2lGxRZn9K4IA0gtA/fPFSSIgcWXytxMiihsIYefNNOPq8QbtF6o
         84zMooes7Nf8L1xZG97UjC/FHtuQoHElpJAtGA8KO8tEfEcXfk/QDMbPx2Y2IGQUZvSd
         EetksXHoLpthH7JGTWWCL6zeftLSHBE5p/hdacNfhd1XzZYDhKQWQGjjiA+VfIUlqwFc
         MBziQZDIdHuWrKANj9scezy1ZWNsp4w2Km9cKkMHafpdh61UeUwjp1A9c+EldSgOn25r
         0E6OgUM+n+ktHP6WMKH1XQcqCjZrP/6Z/U5MBsyZMKfYk1HR/Xo3EWVCANX0W3U3gRt7
         mi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789026772; x=1789631572;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zdat3lb+JFaceCjEvZhP3kP5xpKa4RbvpVHW8sS2v0=;
        b=dQlJ86I2uCXwZwQkHCLn+5FI9QIuU9s8b46NycZNC6Lb4Op6d2+piDlIzxeEk3bVyO
         0MGAQ1FC5B+wYegfhLigSoHFDdmetQXyoa0ewEWCXb9DmU+KA/KyqvbSMraWIeNp1/eO
         mIl17He+08hS/+jj5IEDK6yLhkVakqoYZRWt2EfqUgSeAdRMQnn8O4/oV+rpcr/C66k2
         +g+UQR2KjiMhCgTt1bBIqgMgzTYV+gVfquEeExzQTJt0v5p1xygyqa4Ya7vyoYfmlw8M
         /kmG8FLj+1P6w5rz+TO+ZlMB51+Mc/mj45Iui2CHI2mWM2hfLzj0zlC8mpjpO326Eyli
         uPvg==
X-Forwarded-Encrypted: i=1; AKwUvBznkevE0Slgv2IAHsHye2qTsfV1J83I9ijMPDLutWblcsumhCw0bH34ugu+vD4O7sMs9YG63+A=@vger.kernel.org
X-Gm-Message-State: AFuF++ltMFGcnp8ZFeZoESw5hHdtJ1kSzkGadNU+Qq10tvyv+/AHW32J
	iUOsDl5ZUtRhutO0YP8fkbTx0XohnGTenDTtI6qjQUxhSOM9mmjza7DorfBA+do/YQDy7pZNsE2
	Hama7ZZamYsUJ1l8GaseUShZG/N6cOxRLooFhs0CbPbFx+gpPWGzJ8fDUtSTKUGnALQ==
X-Gm-Gg: AYBFou3TwKC4Je70tkRBdbvKEZC2AQKsQfkO4uLKi2z00eYlzmF9onA6a50LzKz+vfR
	9lxW+jbv2YERmwjEHkzrVA0DXqaZqaXz0Qgo1cXE+cSlrDEr1clui716bQ85NPhyuM/9ue/f+RC
	BpJtD5u5B9JYRb1v0dRNvTM+8hFtvRk5TlUdNWV8RsHefyZgHo9wR5M31CgEuQuB+6xDXKAICo9
	oG2+lllr03sm5c/frfQlx0SmMl48veOaW+0PD6mOXNmWCd5yiGKo8q2NZAiCGQLi0Wl7TVsjMr5
	dkByRaJsx4inDvpJxjNh4XHScjLeA4NzyZ7T42UsEcLNU9x6OSwRXWj9MGZI/PfLTK6bw7r/p4x
	f7jm1/GhE8Tcn1v1ohSXiEJ7PODRVq/WPCicmkjBe2p7NWg==
X-Received: by 2002:a05:600c:1991:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-49d1842f00dmr150578305e9.14.1789026771638;
        Thu, 10 Sep 2026 00:52:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1991:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-49d1842f00dmr150577875e9.14.1789026771102;
        Thu, 10 Sep 2026 00:52:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm48847267f8f.21.2026.09.10.00.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:52:50 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:52:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org, 
	co+6a581c4284f721d4@bugs.sh, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan McDowell <noodles@meta.com>, 
	Ross Philipson <ross.philipson@gmail.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: Fix tpm2_load_cmd() boundary check
Message-ID: <aqJhkjPdib-MQTCT@sgarzare-redhat>
References: <20260901205809.2028454-1-jarkko@kernel.org>
 <apfoKo-BdwaLXtkT@sgarzare-redhat>
 <aqHIwoKcEWeI_yjs@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aqHIwoKcEWeI_yjs@kernel.org>

On Wed, Sep 09, 2026 at 11:59:46PM +0300, Jarkko Sakkinen wrote:
>On Wed, Sep 02, 2026 at 11:24:16AM +0200, Stefano Garzarella wrote:
>> On Tue, Sep 01, 2026 at 11:58:06PM +0300, Jarkko Sakkinen wrote:
>> > tpm2_load_cmd() does boundary checks against the ASN.1 size i.e.,
>> > payload->blob_len. Address this by passing the decoded blob size to
>> > tpm2_load_cmd(), and use it for the boundary checks.
>> >
>> > Cc: stable@vger.kernel.org # v5.13+
>> > Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
>> > Reported-by: co+6a581c4284f721d4@bugs.sh
>> > Closes: https://bugs.sh/b/6a581c4284f721d4/
>> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> > ---
>> > security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++-----
>> > 1 file changed, 7 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>> > index 67225dd562a9..01f18bb37047 100644
>> > --- a/security/keys/trusted-keys/trusted_tpm2.c
>> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
>> > @@ -99,7 +99,7 @@ struct tpm2_key_context {
>> >
>> > static int tpm2_key_decode(struct trusted_key_payload *payload,
>> > 			   struct trusted_key_options *options,
>> > -			   u8 **buf)
>> > +			   u8 **buf, unsigned int *blob_len)
>> > {
>> > 	int ret;
>> > 	struct tpm2_key_context ctx;
>> > @@ -120,6 +120,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>>
>> 	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
>>
>> Pre-existing, but is `+ 4` here useless?
>
>I checked this through in detail.
>
>It should not be like that given that callbacks tpm2_key_{pub,priv}
>provide the length of TPM2B_PUBLIC and TPM2B_PRIVATE.
>
>Thus, it is a bug introduced by f2219745250f ("security: keys: trusted:
>use ASN.1 TPM2 key format for the blobs")

Yep, agree. Do you want me to send a fix?

Thanks,
Stefano

