Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321620;
	b=uO4Hicr62eB6oi4yNdUGKVANg5leqaCL5vUfU7pqFFbrtndUtJzBzTAe9ufCKOo5v38M
	 P+EZbXqLWoDQPKaT+AlSOlFPB0AH9U/MamgnPcY+VOMV7omQgv825f+CtdhInLokETB5h
	 py+JQl4Tu8odsZs6L+o8FP+2thdRnKAlO5rVAVoW9JEDrsVvdnVVyKTGATKPYk+N/69Hu
	 w1lXiM6irDhv8kGVHrSxMDjEiUyCO8LE+bNhUr5k8TlK9yKMGk8ss+zdNxU+LnKXmdvEu
	 RhXwy+KZ6DsZoof0UJQCPk6YOzzfB2m7YZ8sVeida0JZZyDUHfwo1Y52eJgRxk2zFUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321620;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=9FkP82NSjfPVkGjOtRXyI/+qz+a0r2i1CKeWvx3C2dI=;
	b=xhitSZHG24tRKoXZutifgj7tuGanLt6DR3JVtTWSyZIXclYPw2+i/H5cZa+ndzLYkSMl
	 GZHgQReqzNyCoc415aWRecyB3GtC598KHhFHgDUZ8Dr5QLPUsBD/xDalD8sa3JTcUeRB2
	 gZSQbvr5E2eQa81xUbAKKx9PttEXkZoF0FGjnGPdhAvH4LuAvBV2inwq8lkX1N3SiMBzE
	 FfRuSUCn+pO0uMpwpo0jbKUbUwD6ADyaS90bWY6Rd4okgp/f8EA6lenXUXacxvMscKQh3
	 wnMkQzvGeanzygQQ+7hrss4WmIZkQ5smHnaNPPG30RBa0zvWIxTwr7FFzkxVkLI70KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVp3+fJi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B5606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVp3+fJi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4781F008A1
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321620;
	bh=9FkP82NSjfPVkGjOtRXyI/+qz+a0r2i1CKeWvx3C2dI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NVp3+fJiEximT8Zz8H9I9iDtFgXJtSm0JEe6oETmFM6825eYdosvMOkxIiXBSyuF4
	 cIWC7WzCxX4/v5wcnhJo5IpCvTD+TZQ10hnCFBjd2bmL7t6KxQHWvtlts8U90a4j0f
	 rkaPWcBplJHF+FC3agcB8RNEwLq+IF+bOvj/SDhCaWDCa22XnfTsyQ6TZU+yd3lVmx
	 IZd5J/DBnlk4q4/KY1Sj4LhTFU7/Lyrakj7SRh1MTbnAe+1uyzDSPwofUKZCDNzrzK
	 TdeZO/lpDtNSHtWD/Xtd8gTUfd8Pt4x9mUtxlGoWupbWpaW6xC4z3vBaglrJ1fhbfo
	 ILx3ZulylFCeA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b750e40ce2so1544095a12.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:40:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHAy1E1spAWqkye/u2HjQ6SaoH7+PoAHXdTPF9yWyrSeAk3keKxQQXgFnWI/qau3g+DIAH7af8=@vger.kernel.org
X-Gm-Message-State: APuU4Z80E/SUwTHdRyC32mzocberqluu6iG4dtwJPBRTGilrmIhfRUO1
	9FL4uOacRodgg2NNZVCskKgOVc/ZV0+ZDcPmVVbftaNUhWwwGPVFFXWdrwS3nOP+0ksNKRcsKwV
	BUU4jPGReV8VyAfvdD7ZY/xKCazX6SnY=
X-Received: by 2002:a05:6402:22d0:b0:6b1:b97b:745 with SMTP id
 4fb4d7f45d1cf-6b756af0889mr1703428a12.29.1794321618978; Tue, 10 Nov 2026
 06:40:18 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKYAXd-Jo-ObBDs-AdGfaM+QmDsot3gj1g0oJiyDKczoUDg2TA@mail.gmail.com>
 <20261109194144.22814-1-mike.michalo@gmail.com> <20261109194144.22814-2-mike.michalo@gmail.com>
In-Reply-To: <20261109194144.22814-2-mike.michalo@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 10 Nov 2026 23:40:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-nhvaQPNF_=nTTwxa=umN24WfpWgvN8X_UE_P1Vk=dEA@mail.gmail.com>
X-Gm-Features: AclHuK-v7gL0EmbkbxKvWxJdfqe3QqJFytqQDKQtYVZUM0-qKu6IoLKDEwC3iso
Message-ID: <CAKYAXd-nhvaQPNF_=nTTwxa=umN24WfpWgvN8X_UE_P1Vk=dEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] ksmbd: verify the signature of session binding requests
To: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Cc: stfrench@microsoft.com, icb@fastmail.org, senozhatsky@chromium.org, 
	tom@talpey.com, chenxiaosong@chenxiaosong.com, ematsumiya@suse.de, 
	lsahlber@redhat.com, hyc.lee@gmail.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +static bool smb2_check_binding_sign_req(struct ksmbd_work *work,
> +                                       struct smb2_hdr *hdr,
> +                                       struct ksmbd_session *sess)
> +{
> +       struct ksmbd_session *prev_sess = work->sess;
> +       char signature[SMB2_SIGNATURE_SIZE];
> +       int ret;
> +
> +       memcpy(signature, hdr->Signature, SMB2_SIGNATURE_SIZE);
> +       work->sess = sess;
> +       ret = smb3_check_sign_req(work);
> +       work->sess = prev_sess;
> +       memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
Could we restore hdr->Signature inside smb2_check_sign_req() and
smb3_check_sign_req(), using the existing signature_req buffer? This
would eliminate the extra signature backup and restore code in the
session-setup helper in patch 1/6 and __process_request() in patch
3/6.
