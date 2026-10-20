Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517898;
	b=zK+QmSknFwdREDY9KHe3Mf3iuIrbtbVJLiNf/Cvot4bi7b9um/oioBxaeWHtKR8Qy0uc
	 8FC9k7ZVFkO/WGkTXAV9aKtmWmxUolp04Pi4lrd3+biGOLS0105KYG5rBwu822YuBKuBj
	 PDZHfNiQvGxriX+n9I4X3PZsyh5gjGWgKfnp7W4+JlRKMzGYBrgWQ+mdgo++qnFG1cN6W
	 eLThl4gIF2Xt5GFGC4yq9P6HqWq26x20kpLY+1HnPp6ZpojYziwMdJi3zzR+L+FofwHdK
	 8aJ0vcLQD3EJXJZuEg2w4YPxdTniKT/qQ2S3ctjzGsJXD/Gvy1CCRhMl1kqo5tST9Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517898;
	h=Received:Received:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=v/3r8TNEKPTmA62qSgMmjkBfW6wA3NDTsnBMpgNm5gk=;
	b=fKuf3Mbhd8AOuyjaYNWPWBUc083oVO17veYmUR1gcBQVeSP+Mg6o9r6YCELxt9yg8G3U
	 PF5yoLR9j0e/k5eI1f6ScaHmFv2tDpujZJSlGe6oLcsLKYJ7BRu3RD8W/nAMYz6cvhu5B
	 s5u8euOyLwZlVdCarK/Kkty3DX4vRxwp/PqGuPitftbqNEQ7LusQTyfBiwW0VZ/BEDDCX
	 RFeovOoCkOdrGEBMP2UIDraFhJPn0prGIwd7gvKFuZc2Cy/Fwu1AlMOr18Nyqu4YvHzA6
	 xu3LYySwlvNZLXIFHqSrm3znILzcUIILkpScuOiGOIeu9BeAgolk7v9Eb+qmkZCv0Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208D60A2637
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D841F000CF
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:38:18 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f560af6aeso34154985a.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:38:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz6NOZou96f1+o85iCUJFNB4rX94J2a998RNumDfrkTnO1fPegxYvLxUAj0FgtcHlJiTlRH4DQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ5QG5p2ffhLHug4C7ylNwjLt0C+h6zpIweWKW6375XMJeKncS
	fnvhgCApNw4l/xIRrh5JcGvljBi+h5g6HZKch8OlBUSF+d5B36PYjy7NM6mUAbSOBtMOWEs3NBY
	tWZMR4hw1UPDiwTDI6iTVXcewrivrjHk=
X-Received: by 2002:a05:620a:2609:b0:93f:2938:48ba with SMTP id
 af79cd13be357-93f29d9616dmr1909077885a.55.1792517867359; Tue, 20 Oct 2026
 10:37:47 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020105014.97985-1-matt@bobrowski.net> <20261020105014.97985-3-matt@bobrowski.net>
In-Reply-To: <20261020105014.97985-3-matt@bobrowski.net>
From: Song Liu <song@kernel.org>
Date: Tue, 20 Oct 2026 10:37:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7iB59uA4Nq=CsfsyrWSq9K856qQv8Q=e8SEZM0ggmMFg@mail.gmail.com>
X-Gm-Features: AclHuK9-NsxuAA831m7ol4gBimIkAE2CXBl-izBBZR0qJbIURqC8MwEK5TsVfws
Message-ID: <CAPhsuW7iB59uA4Nq=CsfsyrWSq9K856qQv8Q=e8SEZM0ggmMFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: test bpf_path_d_path() on a
 file released at task exit
To: Matt Bobrowski <matt@bobrowski.net>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:50=E2=80=AFAM Matt Bobrowski <matt@bobrowski.net>=
 wrote:
>
> Add a fs_kfuncs subtest for the crash fixed by the previous commit. A
> child opens a file and exits without closing it, so exit_files() drops
> the last reference and the file is released from exit_task_work(),
> after exit_fs() has cleared the task's fs. A file_release program calls
> bpf_path_d_path() on that release, matched by the file's inode number,
> and records what it returned.
>
> Without the fix the subtest crashes the kernel in d_path(). With it,
> bpf_path_d_path() returns -EINVAL.
>
> Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Bobrowski <matt@bobrowski.net>

Acked-by: Song Liu <song@kernel.org>
