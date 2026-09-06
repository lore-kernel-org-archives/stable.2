Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5192E11D2
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788657325; cv=pass; b=YzC5vB7nc3M38sOKzAtQTYvVg7t9TmdSY31q2nQzuyJxkrYe2fgaqDM2sLXyCEu/12tvsB9rsnOlfmu8KrdLj1sEuyHWdyBow2Uotd64EWdA5iaLKYjkHlu/DaaDy9t3INRzDtCtOGdngI0uDsVAwXozC36+Jy0GoCmRUbhpSZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788657325; c=relaxed/simple;
	bh=nSiOrUeX0O/NdpVHm2fy9UY6kS7mLYoSftNiCyut3NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdhzPiNQ8LtBBBVOpsx5wazyp24D6VchAApWw3HCaVLj3bE8y2AE3M4tNNnTaocu777gSX2UseA9H8BCo7nMs/ZIf8fVWTI6HPgZ56vYw9HbsC/tXmKkXIF10nN1AiMgBE2PDffZEy7nKyp1Peh9WSECKvOfA6gO1o4cTcRt4zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJqlPzCp; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJqlPzCp"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666bed443so565363a91.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 18:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788657322; cv=none;
        d=google.com; s=arc-20260327;
        b=O1YekLfMU8WwAdCUW4irrjr5m5BqeJwieRGF8m6dqTtlAGQ9Sf2Gcjuo1Mq32T+7Rm
         TatNe09x3EJbwnUlVYh95B7fs5cygK9pM8+3cjSTnM0uPDg/8K5vq5YhGWBxglrjd4HV
         VBosQMHGCs36XDk0tuW2JwxvoPVMcb5jGjHyFZduG1ix8nWjE1HpnnesyLeVVVvSI/qd
         H30VnS91Vp/yR2daqzJiJn82z5TeYoXxG30DelWY/dDrPZwMZIK3he7uHnuvqMFGkBBS
         jB1oQXI7ybx9AHyeOr1z/WHEryEHaoUyn6i+fhhelJoy+xUI6hOFPpOIfS+Be9kn+1e9
         qGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K9l1UNQdl18CfAL9gkmOy4cmbxzLvH54B1+3p3geHZA=;
        fh=Lzro6kELf1/GMa6dAY+tyFw0xsVm98IleVMvwyXxNzw=;
        b=YWu3a0XMTpq6l1T/EVDXHff8zhQqdnK+L9n1tkhYhwc4KWpBPYUPTEFGw7LhGbsuLK
         8+mpjBikdZCQy3feGhJ6++mOAP6Qq1lW1qb/HFkxdFQsEM84q+MBsZWgul94e9XVahBk
         k4GWIvkc78t8AttXOJpall9wZxF5USN8st3yI7/VyEQjnyub1T0cHauqothScq55A3Z1
         q5SNQYwn2xZzELF6Rg1HJCx+ebQ6bfbXonri4OZSF8UDd8+7s5aJvRHTzvT45x5xi+rx
         7E99lEudaLIoLBDgzeVwSbJnmjU64rXMPXXDbwY/nX4COm8A0zDGfYfK2hb/OBjpvY0K
         6hBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788657322; x=1789262122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K9l1UNQdl18CfAL9gkmOy4cmbxzLvH54B1+3p3geHZA=;
        b=QJqlPzCp0BkmaqdC+koERZg10KSrLkAfxTj5XqGI/lTkd5+in9h4rJAsPgsq6T48fO
         YoeFNlFBtPeXQ5fjedTptzq+YlFLOrxBOXhwTz0DFSFBAVY0irQq5YdPf9UrjrhnLnvb
         VKuDMtSMpFvsTb2hZ/f6khC5Wk0W32v5Dy3cDofTdkkELmfJo44mTQxKPRX/NZdZUv46
         5fcLkknrFKbwBmtqnJi6MDUhrWkUxjFfY08PCGVxoGfjrBOlYzhv/UPh8pbZp6TPJdLa
         IQb4U5GFeuHjXKCQj8/x6mlpHtDIY8aYR1pHTpJwSWnssF6Jl38YjOVdZ9OfmCPVspIs
         S8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788657322; x=1789262122;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9l1UNQdl18CfAL9gkmOy4cmbxzLvH54B1+3p3geHZA=;
        b=QCjy1Qg2OUGGcVhvX97J7yKycm5ETrt2piUQNx5bm5W+PtKbKxe7q+5uvN1VLq9zPB
         Jld7ZafvMyuzUYUG/Woe9jzYyA3RfGDbdc5ElEHg9ziN/P5XM8OUv3g3wRTPg/EVPXAU
         sqLwDQe9qKn8pzDs4g7pStoLGvJDjWOXNEPig8yXHTpi4VbnFsKlXOhSpYSqkf41iQZU
         H5nMSnC1NtvgfxfMEUiEUKwNwshcoVt90Sw/chHLhvRk3sBg9G1m9I5QXClYOrxZbJUd
         AZhqaxTYNXy+maiwhSMzRkh8bNkQci94mt52XzBmGMb+qLa99LASkenKIasn81L3T6wr
         4ZpQ==
X-Gm-Message-State: AFuF++m7/CrZi+RnewFfggqbh+3ht5kr5BOWr0jgsJ2+wFuiVCwzpvN0
	bJ5+oNBqTI08R/pPNJq4JBiOYHPL5KYwuegrlQz4PqV5oTvihKWOJQ/ZMgWi4Q9CmC7wcTPiWeA
	Jxscoefa1E62+1wttP4F0XLzTnY6QKMo=
X-Gm-Gg: AYBFou0MxIuYOzqnA/947a0q7X37lAl0R1G5mg4r09/rsc25ptx2Cz+UDI04qKrH+a6
	O0UdCMdlT3y8B3IdZhKlfARZsCT5xHNFgSYXFPFgN9a3x5e8+dk5p+ViN5NyUNTMNzEIVRw4Nqk
	R3dltDqqQTEDpC+lKnf06oZUZCPNylfoNlkBPYZwinB/+nUxXqU1Ds/H+9gLf6HM/aUmRIKqBJq
	L8XIkQ+AkOy6gfLprvMeqB+Ej/13cEjB2gxRMwU4ZVJFU7iXMHhrVSnbklmQYMn5PAxzlEJ8FGP
	/0J/zGoyhrBXTcgNIGTZKstOO3FTOfR6KKZUCDvMn1os0s88FOtkfc2r9jdQSPqt7+duYyVIe7z
	vMc21INs95LDtYR6bCR28ujLjIyt389XgDXrL8KacI2sgAM4wxPJaBBeSJ0ZH
X-Received: by 2002:a17:90a:d64f:b0:390:af7c:fe5e with SMTP id
 98e67ed59e1d1-39b26741434mr15019221a91.2.1788657321824; Sat, 05 Sep 2026
 18:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904045747.813364717@linuxfoundation.org> <20260904045748.373148168@linuxfoundation.org>
 <CANiq72=EounScE9CxhQVRYTMe6XxgZzfid_cJZ5dxmkz7MQ2kw@mail.gmail.com>
In-Reply-To: <CANiq72=EounScE9CxhQVRYTMe6XxgZzfid_cJZ5dxmkz7MQ2kw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 6 Sep 2026 03:15:08 +0200
X-Gm-Features: AcwNN1UFX5rjdj7_KLFJKMDwiMUh-IFANsRgF-3WCWVLBFVMTTj267Yzu5Wf_BY
Message-ID: <CANiq72kOxeRSi7Pria6hv4T_HeL_hRVXdq61nvdGe66GpQ0AAw@mail.gmail.com>
Subject: Re: [PATCH 6.18 024/552] rust: bug: fix warn_on macro build error on UML
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:04=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> In 6.18.y, this needs to be:
>
>   $crate::str::CStr::as_char_ptr($crate::c_str!(::core::file!())),

Or we can just drop the patch, since it is still our `CStr` in this branch.

Cheers,
Miguel
