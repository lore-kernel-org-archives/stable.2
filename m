Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3684D98EB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457097; cv=pass; b=rA7x5Q4patKWiX6U3st0jmR9AFusRcOPMbaqS1/z8YsidH3tpYosHJtnproN22ka0KyAC8V63Iy/GltEgtikWug2KbaUrDSemSLwe4X5NY0yRhjgDjNIDINwNw97HslfKBxsaRRtFdbOW2AK/LoQceHB32FxFPwNBthHwt7inxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457097; c=relaxed/simple;
	bh=Ze/S4si3IBpGVkJFS1ZECe9R7O0M2pJ6OQiDmWqlEn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvLGrUiZTkR0KMeunBFoPfL18RRb80YtJ3J+tPSgwxVKYiT3kceofCd3qbzLJVoaGQwedYRxoTK302pwcti1Ap5sYzbDqlmgdkHCxSe3RrBRJew4GB+4Gotlv/yD3HEAdYPGxNFoa7l/KdEUtsgb2HSKAcJLAvOoM3tDO769q/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfiZv+fE; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfiZv+fE"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39b1c184ec7so5825a91.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 10:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788457093; cv=none;
        d=google.com; s=arc-20260327;
        b=ce3Z0SUJgFdlUyiTCFU9CTXD3HH3A+65AK36iCeubIR+tax2KsrNMn3te6llWvF1JJ
         y8jWi6gwirgzf7vMQlLkYJSWz79WmaICHXe5T6kdcruBfLeYfXeZvLDbaSiZ7BWAEuyB
         JtGRjkQiCQPzeEqfuWzr/VDrWBZznNNIJOnTgS+I62RkilIKNMZOHvzPJnEJYx09tGMi
         Gb2cmBtJBSRhCQvmjSYA2KP3FvjGlCzYj81KOquehgq1niubiyJLMd4tEXA6qiiEsBRu
         1e4598x7BwEDrFNCe++Qwr9LVm1wUDv+ETxtEAbzunUJeZBE4FLoXXB2aDUzWSFCBHFe
         X71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N7g91cZ8R58tU0W86dwXfAvlXIqDgXsi+wt3itCHApY=;
        fh=7Cbj6U97E7Az2uuxou9Kq5bdm6SaXQjG+ywbiPQoLBA=;
        b=ao9VNkKAByK3uA21Id5BkAFefq5LjejUFlRc61t3veXx4aFojPrFisVYNocXP8V1TJ
         wy7EZBy5gM/yNNVdOXvsijm/Lly7VAlP17pBfQmkUHwovClyM/R3DXzeDJ5sk8ixi/97
         PQ1dMHjo+TsoP46uibO+19bU06VHFXi4/PbRtfivVUJpnvxVzDmXibDIF00BBZeQsQSm
         Q3GS8Yei0kjg5ke7BC02CAIoCkRQlEOx3V2xWJ8/smo1kpAkpy999hsulgIiWoqnUOaz
         DiPKmmjvCZB1AdN5n6pNwdjfLYVIjsPjd1zb7dWAw0XUXyBgTY2oHp8iWc/2bEz6qBAe
         eNhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788457093; x=1789061893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N7g91cZ8R58tU0W86dwXfAvlXIqDgXsi+wt3itCHApY=;
        b=mfiZv+fEOUgPaV5qzcSxJCdpIGb3oQktCXwYyz/yCykNXDtCIctU1hyVHJYZUvmjat
         FadjigAsXYIK+N01PmELTiYpchIGNoVH5SmSaMD9N9VqPyxrmzMBNpKJ/x0jDzOusRW2
         oFDn6ChbV1bd2jmhJQ+pkGLsScv81ayBTtZje8VKHea1rDPB0kSLMLtWAXg94ywazxZB
         SE+KJ9OVYSG9i1xhRXl7larYcNzUwPdsoopVKv26wfsPB23fvoDUC5HrJSgIeb0ZA/TF
         +td/Z4VeKsEKqiSXpV/S0PjJ31jR8fcKy5Vbm0Wm4KCliYvIGrNgnZCsEbNHnTlthf/M
         xtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457093; x=1789061893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7g91cZ8R58tU0W86dwXfAvlXIqDgXsi+wt3itCHApY=;
        b=beVNnHwwqD+JlfL2oh/0rBq9ZzMdhqbMIx5i0XdfJyM4A+v84MYO5C2ZLgEvWwHDMo
         yCI7MGdINtuIeY6+T7Jalu8uOPke8E1OT/vDXrUbPgD8Jr/412z1pmzS2VRf7DerZJnX
         4Jgjhm7cMUEKMhnTGfg/mcRuf8WR1F+HAgm+wPHxbnB+LHzcoG+vXonncyzYojBdK+BD
         7jIfbBCvqED/21fbcjhYBVa7IOe3FNI6KbEREo0fUYRqlzCp85l6SCmUn1vI8JkoOMCR
         ucc/J5qBXDos0UrM1pW+2tLHQcGNt7aatPo8Qj8v5HwSQzTbY8BixEYnhStlzqyUPzkv
         2UFg==
X-Forwarded-Encrypted: i=1; AKwUvBzKK0VMWlI1cmk8k+/k1kCu0vB5PL7Sr86H++sseXEZ7cnVn83WNQfafwlYpSXepLJ/7pPbG3M=@vger.kernel.org
X-Gm-Message-State: AFuF++lIutXyXGObCOpkDA7BlbJ6bB7L1m+EZ9VqOFa73a2DUQHj6aNB
	bpsiAXknVKpzRumtlkjTa7atdSGNNgKHKX2dIuVoV23XN98qJYmDPenmMgobAcS6/FcFKyGQ/5T
	XhMlbDpfPexbv6IfcDvRqMOOJEZI3MvQ=
X-Gm-Gg: AYBFou15BKVKIJUR7POSPfSWsxvd8PPtBPxKyxiD3pKXKUmif/nQi/X7qgvaiFadFqP
	FVEzS4JZ+5PChUVPuBW26KFgIdhxsZletMjHo7wDERjluy0o5+NfZlfQQeXmQdOFBeJ5oMqBRGu
	KrFw8H24MqEVbmJELXOlkDuBr+mau9HWpt6u2kP6v70jrmHvaJvAKHXmBcLztJIDvEGONWMCaXW
	mx47EjWAxh4TRIDwNel/0ftHvIkl1g36OmiNkbT4+K2kJvUQ/HpZT9FXgt9MEtuL3wcXQlBxOSp
	RY7mY+1CSbRm7gkmC5dKYGRu96VsBAb75xqj961Av0wrN7gCRy/2NzAHIFFZtQHjhwsXRt28Fk+
	CstrvpcSYqkyTLAVQpNElQO5LlI6D7wE1eZ/KPAbtZq/2y4et4QgJQ2CYcpLi
X-Received: by 2002:a17:90b:2e42:b0:398:bada:832b with SMTP id
 98e67ed59e1d1-39b262f4925mr34022a91.6.1788457092990; Thu, 03 Sep 2026
 10:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090341-pyromania-recoil-5ed5@gregkh>
In-Reply-To: <2026090341-pyromania-recoil-5ed5@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 19:38:00 +0200
X-Gm-Features: AcwNN1WrbhhR-zT9HY0InQHFd0FCohSJ6hqQ6ssTTX1UZWhk8v9q6Gi3dJvxsGY
Message-ID: <CANiq72kU1hJWmHQFthrFj1J2DuNVz=y=T-FyHWogaae=p__eKA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust
 function" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: ojeda@kernel.org, aliceryhl@google.com, jpoimboe@kernel.org, 
	peterz@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 2:44=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 993f235c4af49d0e912cc28abe6d733531600237
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090341-=
pyromania-recoil-5ed5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

To solve this one and the related ones, please see this sequence of
cherry-picks:

  https://lore.kernel.org/stable/CANiq72kmYx5GBU7VL3z8h3bAWB=3Dvw-TX+ptskDO=
0k3Ro-F450w@mail.gmail.com/

Cheers,
Miguel
