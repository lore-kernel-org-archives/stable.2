Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792513436;
	b=SbMKNzL/BxajtVVAHJPWd9We+LB4MaF+gQCja5tlIPVD7MpzSsKRcQEh246x86gA2pWw
	 SVPSz+vZji0JPSuibt98DPu/HSd2kfbFPyVKxeqiD3UzG/z6R8pSoSIKzJ+mB9R/Qcu12
	 r6v218WOpV7WUgzsqTa5yzImeDF45A4zIdtPPnSKqS0X1p5tOtu0ecM2NsIfK+sAs5v3g
	 LXMuQQKgXVR4tiF9uJ1JFJBVKsppoDuSaDf4aoREpPgcudfaFg4SPQauvccJpjVbkeTnu
	 4p6zQa2YUxKNH0pn2iynBsUxi2ql9oILnz0KSzFFyoc1A1fkm2PlR1REAluTU2vTZ4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1/TU1fx5Q7KS3NNxFTqPhkwN2RAGL4ewSYUEXSsjILU=;
	b=leAVyl3C6ippTJOq6JGfZrp+IIRVQoCYK74TQ4cYjTLNw2cGog+aswCr960o6F2SurvY
	 yZP4T62LHXF9PxDdMfjNgwIHA0HGF3IDSRBcZiA5WseneSHObOQFzflyXXxvytl7karG9
	 wwCRFSQIpwBTU3e1Qh3XmM0bOqAvmmFiI+kvwXS5q15o4giTnFS8HuoDVOvYbVOzVvl03
	 Zq+iz+rpZhCStLlvCQJ9B9GqoQAanww9gERf0r2PDwa3CWfO3Ww7Sh+AQnOc+EoF9t7uK
	 B2UtLMkJOeSl9BWjqVowTyrroTGxcKlJPpUe6hOk501lEfQ/inPvkqhJR+EIJBTVkog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nNJAyjCA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A6606A322
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA8A6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nNJAyjCA
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35159e0092aso417908eec.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513435; cv=none;
        d=google.com; s=arc-20260327;
        b=RZZ97/Jo4rRSGl3xj35vNVE2dv75CSuVqsC41rqPWhz2Iz13F977mNXM4hfKeZlOfz
         w+R0LsM7lIPAkJ/dzWqTLekwAJRuZ9pBmmR2QO0y/1VuJILq9Py8RDJKHVWn/hM/b8gQ
         Gfxhj6C7Lq47OxaHXVK6gWyqcb8EzEG1AJ/5WQa5HLJkX4XHHiH5BMs1aloncww/mydk
         6+8wx/shsFG5/6afv9Ff2j0jghMotTqfiJVcfKXJ9ZBgGDsaFKoBIdwPsJYJDdk+i0KL
         jmL7QYF268ophbWT4zZazuTzNKg2xUa0nYZmMFN9Vl4e0rUfZDsgwCrIkMYExy1e7EsZ
         RhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/TU1fx5Q7KS3NNxFTqPhkwN2RAGL4ewSYUEXSsjILU=;
        fh=5t3MrdaU24C6TxqKYfwbo8HIBZr8biNJqeN6/Hgj1rs=;
        b=X4gWSoh8NrEW16JE1tjMcvNGSTqkzutmzZSUjbBEBDaiiyYIo38uBCJwgpUHyqO6ag
         ucP7rCdpn1IxOmWVOa4jhT/M3GDaujOjluaTxtusfD0bmzZBTFh3dLfG+xow6xMxocmG
         tpvfH/o0cZ5Q+PmwMpcM54KVYX9ChHjB1PnZzRAfWef+rAv5IXoZ4V4AJ9o+DoCXz5eA
         BMgvd6h332Sg5NL4GgRLdvipkGcYOOiSxfjfVyoHw7iSzuLHJ2LpyEd33tsjjQ4CpFpi
         oWbHlVHGsrDx24JmDRvxq5sN03DA9X4bLsavHipoUc84SMxEqEYRi8KQRkFHKitIBuID
         N7pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792513435; x=1793118235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/TU1fx5Q7KS3NNxFTqPhkwN2RAGL4ewSYUEXSsjILU=;
        b=nNJAyjCA1cBtwTNsbNVgKbr42Fi2rxrR0AfP1I3EeNVC2GFOPbZzecenbHeKcp0763
         qlUTrtVJHbBz+kOuCzFOkQsDsTFo4W3CIiQxL+dXKPxYMKuPL9MGv3c2JIPRu/SGDt9t
         wRGSzHBAxq2gIQaYhRjmaoOVm6IvWlSd2hLmnzUoEEI7PDenhNsNoHVAnGWxBXqp6Z4G
         4GUiA+/JjyrtHoXM38Ik1qjtKbQ3+epNp+KSjx1NeRqAu3AI4TtVaPgITFEMLjJW3Rrz
         xE2SQkOuL1B20fBoNghYNTqsAnWLHLpp52JYVQUAcXlWWX+22A2MP8MlLzcVKezcpgIO
         5yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792513435; x=1793118235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/TU1fx5Q7KS3NNxFTqPhkwN2RAGL4ewSYUEXSsjILU=;
        b=NWp2CyEiXsNHCoAvxi4AxsamAFvkFyK3QG5jGzmeorKfE/ALbFU6VnuOSejEvp7nZE
         moLzfR3xgOv3VFtFnmCXKkJ4ohmqqN1QARy1l3osyIbMO87m1LrYGta2gEXUvICR5w8t
         5AUaF+BPOmRoRGsNLD1eW+ejUPDmpYlHTIyWcFSW4Kx17v4YycoNIB4jyWT+z9/NH3fi
         Dqcf+3xWbFeoR4heILpgwtgkqu40E5PWq5wE/aO5LX1TWUX1RK7kt7lkG49OVCGV8eSd
         MFTXet+5egT5BD79ZP9o6Qwtq9eHue+LC7f6tY1ZMegs6fT8sG5LHUGUZGCpxhR3QeUd
         0UrA==
X-Forwarded-Encrypted: i=1; AKwUvBwDcm9GHASpTPStKVyJAdbA/snnKttpUVfxuPCmhDlMHywuQWrTDKzMDxyifOVe3l0WkoaotnE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5Lmivxt79SMzXQvagNxIf8MO6m3OEGGFcu8Ir2ck2a6zgtTHe
	ObIuAmFbd8u8BS3DImy9+GIYVyoMKfeYInvM1B3yiNKGpi17et8uGeJKHUW0Zos4CcKKAopL9yp
	mZaEPpqo19M17iBnQYvb/iK/Hb7j+Wns=
X-Gm-Gg: AYBFou3Vbz94cNagBCW366THPk+q/EdMyjSecVjqS/hB9cFVGQdsgZrP7jWDiCnh1s9
	tgRNfeuOay9CwPvIMpq3J/w8dxrjrYFXuXite987+NsdAeFKGAOTi9+ZQ54VzqkRfzbhkL1kGS7
	6Rwp+x/+AnsNiAwjKjhgXS31x2ULyZNQeMYCQwqnxvbN2a15E5z+AGiYAB9vIrsr0bxnxEWh75l
	00G4RfKTPCuqSCS3tESHrnqHPkAtrcE0RViI8DsXlnpRGWjQ5TxvlP2Evk483DtXPRLFOetTUTj
	TQG//Dkovjb6NhsuZQNo+2SSYPBmQBeBPRSMRrazyBERPpoZvR/W6KJ4ebDD/c7lj8Zj0hdfKJX
	gb+lh7NGK/x684c3qdxUHZvnJQ9PFHLUNgj+PuAiuRxewEUndN3Of4j/u36Rb55dnD7b4Njo5fb
	p6kgdtCVN8RwPdIhR91OWiQnT1P3Pp1yvE3/k8fg/mDel/MdMQtWUYb3f/dMJ6bw/cAvZTFRbM0
	Ol1LgXdqGrJsLGzof5nj2zhs4AVmAp+n/lh
X-Received: by 2002:a05:693c:409c:b0:35b:cb8a:8ce7 with SMTP id
 5a478bee46e88-361a06a6544mr28167645eec.1.1792513434719; Tue, 20 Oct 2026
 09:23:54 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016152828.3765695-1-sashal@kernel.org> <20261016160030.118973-1-ojeda@kernel.org>
 <20261020133156.3153106-1-sashal@kernel.org>
In-Reply-To: <20261020133156.3153106-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Oct 2026 18:23:41 +0200
X-Gm-Features: AclHuK9Pd22EdXpHIfqU5N44FLer_q0ZOIvVGA7MYMY15OzC7aZuyhpkAko0zds
Message-ID: <CANiq72n9q93=usmoPqey_ohnrZ_nQOwvZfPYLAXgb0h1-NSjEw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] agents: add skills for Fixes tags, stable tags,
 similar bugs, and commit messages
To: Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, broonie@kernel.org, corbet@lwn.net, error27@gmail.com, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, kees@kernel.org, 
	konstantin@linuxfoundation.org, ksummit@lists.linux.dev, 
	laurent.pinchart@ideasonboard.com, leon@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@leemhuis.info, mst@redhat.com, 
	rdunlap@infradead.org, skhan@linuxfoundation.org, stable@vger.kernel.org, 
	tytso@mit.edu, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:31=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Could you send it as a separate patch to Greg and stable@? It doesn't rea=
lly
> depend on this series.
>
> 3/7 only drops rules that LLMs follow more strictly than the stable trees
> actually apply them. Adding a new kind of fix to the list is a policy
> change, and it should get its own review rather than ride along here.

Sounds good, I saw you split it in v4.

(To clarify, it is already the policy in practice and it is documented
on our side too; but I agree it is a good idea to discuss it
separately).

Cheers,
Miguel
