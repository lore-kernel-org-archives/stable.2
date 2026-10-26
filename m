Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792980633;
	b=08SK1+zZGZsAe6CR+Y5j+AEK9/qZxM5KgevU3KjRCd3+pXwi54K8Rx0EHzFdsjj4AkDF
	 ttI9+j1WpeG1eAwaNIGYNO2dfMyzUcNvAUkalfkNl9QrDe2lch0ZzGwHpTPIJasdAVApG
	 nsdRXR0sMGvyZkJOPttmXzVxDwGtx3b/EE6C6ThI33CWDncG2P5fkeiByxpE8R6P4IbR9
	 m4E2WWDdsACwmVy8cFwQpGjacOAzN3Z0zpzynO8GoNguDiSbOfatnE83qkzjE8PraEVs3
	 gQASPuGNiyn8CYrui3+Xwvlsu8JR7LH6icSopzPEVqAEBLQXqiPEM8bzJl+U6EUsNWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980633;
	h=DMARC-Filter:DKIM-Signature:Cc:Subject:Mime-Version:In-Reply-To:
	 References:X-Lms-Return-Path:Message-Id:To:Content-Type:
	 Content-Transfer-Encoding:Date:From;
	bh=fnUns6xcVSzCqzpV9TGsqBbjbhVeYf0cM+x/ILg6sHg=;
	b=rKAaSPAF8j/lMm4l/CzyiyfikWT2Dl9VDRhYH8RFt2NnZOvGVam020/DP3HQ343La2o2
	 nsAyBawmdMcWd751G/L4utmLux23Y8Do64aPgQberW1g3iPlUnInA/B69UmCqjk+1RVD9
	 ErcceyXRXz7b5XNAIhojtH6aHEBpSCEwZWfi9B0nX98cVDD9+mUBjq9GQhJWplERljNIb
	 w2Kv57GKVioF7hbdKtjViK8rRCmbEt9MEoqKWu5YDgbMjyQuwXewJ9VhAhdaDV1xMnUas
	 GvTE7Un1ijs5aW70yuDllFtBFG917zmaWU32R9ygc6zXNHKLe8dsWKLMPsVZ6aiewKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	arc=none smtp.remote-ip=209.127.230.113
Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBAD606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BBAD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792980618; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=fnUns6xcVSzCqzpV9TGsqBbjbhVeYf0cM+x/ILg6sHg=;
 b=UoiTXtfdZ4H/G4T1FmFfV3lADpmS8aygEimu4SePcrHyp+GqMGBFqzAtAOMTdJSFZamCvT
 0l7/eGjpnsrIEA6rk6MqovDADRCuRdj7OhvgygLfTdo/+zNFDQrbIuDDTyGafaFXB2lTyo
 xoj3MaKdhPt4kl7Yi6nn8bikchvxaDEmj1n6vjeW22FlilnwJUnR3mb+tTU3laVTDPtRJ+
 NbvAHDRRS6o9EtljI7llKYGU5Rk4Y/IygOI+awO2b7YCOFCvwNprBDPhVcIW7/OOmlMf0A
 upj++6cbwWRYx4G3fDKG65RhomV7vvV6/GlfWybxXCFo2gzZcrxI2He8S3VpIQ==
Cc: <x86@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, 
	"Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, 
	"Dave Hansen" <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Guixiong Wei" <weiguixiong@bytedance.com>
Subject: Re: [PATCH v2 1/2] x86/fpu: Fix memory leak with dynamic fpstate and exec()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
In-Reply-To: <bb50436d-8af6-4420-b626-97f262f6759d@intel.com>
References: <cover.1791428412.git.weiguixiong@bytedance.com> <b9277cad5e1098d3e60d5c0f025c58061df10af0.1791428412.git.weiguixiong@bytedance.com> <d28dc497-a74b-4c52-bb6c-8b9010f9ee2d@intel.com> <89727492-b1d1-4f14-955a-0673ebaee753@intel.com> <451788d5e97cba38274e663d2b7952c593e959be.299fa9aa.210c.4b1f.9ab7.7acb67f42a19@bytedance.com>
	<bb50436d-8af6-4420-b626-97f262f6759d@intel.com>
X-Lms-Return-Path: <lba+16adeb688+6aaf44+vger.kernel.org+weiguixiong@bytedance.com>
Message-Id: <451788d5e97cba38274e663d2b7952c593e959be.a7410b9a.6322.4d63.ba47.f773788cbe75@bytedance.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:10:13 +0800
From: "Guixiong Wei" <weiguixiong@bytedance.com>


> From: "Chang S. Bae"<chang.seok.bae@intel.com>
> Date:=C2=A0 Wed, Oct 21, 2026, 02:21
> Subject:=C2=A0 Re: [PATCH v2 1/2] x86/fpu: Fix memory leak with dynamic f=
pstate and exec()
> To: "Guixiong Wei"<weiguixiong@bytedance.com>
> Cc: <x86@kernel.org>, "Thomas Gleixner"<tglx@kernel.org>, "Ingo Molnar"<m=
ingo@redhat.com>, "Borislav Petkov"<bp@alien8.de>, "Dave Hansen"<dave.hanse=
n@linux.intel.com>, "H . Peter Anvin"<hpa@zytor.com>, <linux-kernel@vger.ke=
rnel.org>, <stable@vger.kernel.org>
> On 10/19/2026 6:49 PM, Guixiong Wei wrote:
> >=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 void fpstate_free(struct fpu *fpu)
> > =C2=A0=C2=A0=C2=A0=C2=A0 {
> > =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 __fpstate_free(fpu=
->fpstate);
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
>=C2=A0
> Hmm, just curious why the original check has to be removed. I thought=C2=
=A0
> this sanity check from the struct fpu context was reasonable, no?
>=C2=A0
> =C2=A0 =C2=A0void fpstate_free(struct fpu *fpu)
> =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fpu->fpstate && fpu->fpstate !=3D &fpu->__=
fpstate)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __fpstate_free(fpu->fpstate);
> =C2=A0 =C2=A0}
>=C2=A0
> Thanks,
> Chang
>=C2=A0
Right, will restore it in v3.

With that check back, __fpstate_free() ends up with fpstate_realloc()
as its only real caller, so I'd prefer to drop the helper and keep
both free sites inline =E2=80=94 same shape as before v2:

=C2=A0=C2=A0=C2=A0 void fpstate_free(struct fpu *fpu)
=C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (fpu->fpstate && fpu->fps=
tate !=3D &fpu->__fpstate)
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =
vfree(fpu->fpstate);
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 /* fpstate_realloc(), unchanged: */
=C2=A0=C2=A0=C2=A0 if (curfps && curfps->is_valloc)
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 vfree(curfps);

The fix then collapses to two changes in core.c: free the dynamic
fpstate at the start of fpstate_reset(), and clear dst_fpu->fpstate
to NULL in fpu_clone() before the reset. xstate.c, api.h and
process.c stay untouched.

OK with you?

Thanks,
Guixiong
