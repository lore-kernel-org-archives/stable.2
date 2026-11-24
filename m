Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564154;
	b=zJfUN+utyZ25t/g4BwQHq7Eu2c1TMiQqtfVKl3WG27eqF8xj8DtUrl94DarX7wbgt5Xz
	 sR688ZfN37Vu+Yj8UlkeUDIxD6frKsM02oAkmfRefuyjSdGRiMulBVScInVz7IYthdxYW
	 qzk+/MwA2z+gdxOfpcMdwJc31ImE+2xA28/sZrCeKB8Zb63m6Erze9DSX/+GclaceY5xw
	 8A0Q0irXi8fXnQBqaTVimUgLa24//Nj/i+DaCzLS0CUn6c8rxTp/9UhR3g07tzSsplo/8
	 gYyS89w3ooH96KyvFKQmwGaA0b1tA87O7HIXe58rETRjtoiEFkiLkVq0QJFMbXM3QUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564154;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=DzVCyim1+gn9POglvsFKaOvJSiB4wTMgOv/rH14HWB0=;
	b=DWYpRpsDShe8tBEbYZKzpwX1+aTSI425Lxm/efWeH44bjjJhkexeMSXrDxG308NdA884
	 A7geQ9UYyqeUFSHZUHYIpOmbX6jenZEQjwIl687mhTAyDU9dAfOG1WViOQ56lYcfflrGV
	 lKbpyGLsPhxHCKjdYOJfN/2LexFtwH2fZhsX6x37z61y1G/lwNVuSHzcyCffYIagZ5TAF
	 rH6EcP3C2TPUHKICQ8ZbMqQrGuCruYE2nBkD3lhMj89S7LHEarVl27Rbyy27npdqqUmqb
	 ECQ78HAN3kxnqhRzR2958QD5jew3NRJLzDDJQAIiLe51yulZqU+twQaAbC/t9lxEy7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWH0qSAZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F2606A327;
	Tue, 24 Nov 2026 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWH0qSAZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878B41F000D0;
	Tue, 24 Nov 2026 23:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795564153;
	bh=DzVCyim1+gn9POglvsFKaOvJSiB4wTMgOv/rH14HWB0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JWH0qSAZTjFl6LjnHlO8g82S70LK9uxvihtFlxNyDhhs5nY326gdIHYnixSjHmfaj
	 8Vd+Cbxr1IGXcnzxBME7sk4u4ky3aYbDxOzVkOdcqxsDaymjVYRqMXQadD05pB9kV8
	 2ez1Axbs/sYM180DOmkFOSY5XTSgMglcfSs+Qnaevf7h+kmZZW2hTEuMBPTaTumHht
	 fat1cYvsxmv5C8j+TzgeGNHb/kcNZ138P5eZgLX+3d5UTChnqU1MS6oNG03z1vZDy+
	 OIZK4tk7e015n63m+Nb2xcSnz6tIcKV+EQisMwZYd7Tkc39xqCcfnYhcpXU/NrC7uP
	 PVSxLH3y9+AEg==
Content-Type: multipart/mixed; boundary="===============4896982406480640730=="
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cd715ed46deb14d0a7becc6defb029b6862024758c2392d1cd203e806446fdca@mail.kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-11-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-11-e489035395b8@kernel.org>
Subject: Re: [PATCH RFC 11/19] selinux: revalidate inherited files before taking exec_update_lock
From: bot+bpf-ci@kernel.org
To: brauner@kernel.org,jannh@google.com
Cc: torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org,acme@kernel.org,linux-perf-users@vger.kernel.org,bpf@vger.kernel.org,selinux@vger.kernel.org,kees@kernel.org,linux-mm@kvack.org,linux-security-module@vger.kernel.org,apparmor@lists.ubuntu.com,david@kernel.org,brauner@kernel.org,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 24 Nov 2026 23:49:11 +0000 (UTC)

--===============4896982406480640730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selinux: revalidate inherited files before taking exec_update_lock

TL;DR: Moving flush_unauthorized_files() earlier changes the comm logged in
SELinux AVC denials to the pre-exec name instead of the new program's; asks
whether that is intended and, if so, to note it in the commit message.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

> +/*
> + * Close files for which the new task SID is not authorized. Called before
> + * exec_update_lock is taken as closing files may block in the filesystem.
> + */
> +static void selinux_bprm_revalidate_files(const struct linux_binprm *bprm)
> +{
> +	const struct cred_security_struct *new_crsec = selinux_cred(bprm->cred);
> +
> +	if (new_crsec->sid == new_crsec->osid)
> +		return;
> +
> +	flush_unauthorized_files(bprm->cred, current->files);
> +}

Moving this call changes what the resulting AVC denial records contain.
Denials from flush_unauthorized_files() go through match_file() ->
file_has_perm() -> avc_has_perm() and are formatted by
dump_common_audit_data(), which logs the program name from current->comm:

    audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
    audit_log_untrustedstring(ab, get_task_comm(comm, current));

Previously this ran from selinux_bprm_committing_creds() in
begin_new_exec(), after __set_task_comm(me, kbasename(bprm->filename), true),
so the record carried the new program's comm together with the new
scontext.

The new hook is called right after close_cloexec_files(), well before
__set_task_comm(), so a denial for a revoked fd or controlling tty now
reports the pre-exec comm (for a fork+exec, the parent's name such as "sh")
while scontext is already the new domain.

Is this change in the logged comm intended?  The commit message does not
mention it.  If it is acceptable, could it be noted in the changelog?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45508356147
--===============4896982406480640730==--
