Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4C417355
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337635; cv=none; b=tSYbVsvKBWi9wEYDywzH+DzeJP5YnQM5ts+EPrWPqm1liBOasbskFTJvsw1hYyCFGeLEoUQptCXYCI4SR4NqhuRz4YXItGp+tGOolewqclRVOs/qT+ukIpjgq1k9Z7uGIMSmrSDW7gurnSruqNsCKG/KTxft+tnD4z5oXEc58tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337635; c=relaxed/simple;
	bh=T6ff1X1gPU9qIbDk2ANvJa5G+nOvML8L/09s0oqCN2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMH+nXSZdMHhDrWMRA8W0i/CO0lPMU4URISTLcea0vS87dHdyksv2IBqKk6/X5trH3mWVtH2UUDm6Xgsz9cGFw6DlI+jjTcacuxdW46AgcoUYihcYhPyT9WgN7evmECyDDmuz9Qom7EPIpfeEydQ3obrESt5K3m3mDXu0TjltC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0hK6KJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0hK6KJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7C91F00A3D
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 11:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783337633;
	bh=T6ff1X1gPU9qIbDk2ANvJa5G+nOvML8L/09s0oqCN2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q0hK6KJKokE4qVK3fqqUG0/fMy+XEEZ219WY0O/VkHNtAPvXfGcErEO/wl28KrXgU
	 kGbnLNjBr38jmLIGUd/OKm/9rMBh5dteTEUWTt++H3eU/COHFYRvdqOA3+DrYqk4+E
	 87rxvKTWOqkG0pvTPMvT+u3LzdQV/v/5RdEmLVuIkWeBZ1942NqWbtFuAsudUzF3CX
	 5I575zFMPNEC3KHpofCA7yOx88fcEc7WQQ8d7B5KDST+qUoqkQ25MxnUdxeVfGhw0P
	 b95I6kmKFJH2mTXzLZKkTO020R0TSR+rJUNTPLLaQHRkqYoaPxL72/991qS4lue+U8
	 0IQV8ehOMKR7A==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c126553552dso388048666b.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 04:33:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RreZ7z84pthfF3hAjOVF4V2UD+W346ii4aHTRg+QkHMsWjobZt005YrzDBA+OoFsFvplafrDyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQvrjzL1Qdyw0dOpnIc1wJqs1HGmPEI8yhjWgOhkhm1n+uOH4
	7AhCuf0z73Wrc4d9CbDXTfTzMkUDgfCw4ziv2T+yfpDexacAD5jbT15UoLekFCLSyl9+xMo5tKz
	ResBWCAnCIaD8Bn04TvvlLpD7vweYQNE=
X-Received: by 2002:a17:906:6b1a:b0:c12:8e66:cf58 with SMTP id
 a640c23a62f3a-c15a68ea862mr4305766b.30.1783337632575; Mon, 06 Jul 2026
 04:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0B853B9F28048C99+20260703054528.2798189-1-peiyang_he@smail.nju.edu.cn>
 <A82793FCC5832BB2+20260706040015.58048-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <A82793FCC5832BB2+20260706040015.58048-1-peiyang_he@smail.nju.edu.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 6 Jul 2026 20:33:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Q_DuR9LxgabRmu8yVkvP-ma_-+VdganL81o19tVs3_A@mail.gmail.com>
X-Gm-Features: AVVi8CcFdYL_OySHhNVWhC7cySF0ibSWgpl9gQcAL90fDZjRArwRYgH2cCW-hzQ
Message-ID: <CAKYAXd-Q_DuR9LxgabRmu8yVkvP-ma_-+VdganL81o19tVs3_A@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fail attrlist updates when the superblock is inactive
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 1:01=E2=80=AFPM Peiyang He <peiyang_he@smail.nju.edu=
.cn> wrote:
>
> generic_shutdown_super() clears SB_ACTIVE before evicting cached inodes.
> If eviction selects the fake inode for a base inode's unnamed
> $ATTRIBUTE_LIST attribute, ntfs_evict_big_inode() drops the fake inode's
> reference on the base inode while the fake inode is still hashed and mark=
ed
> I_FREEING.
>
> That iput can synchronously write back the base inode. The writeback path
> may update mapping pairs and call ntfs_attrlist_update(), which
> unconditionally calls ntfs_attr_iget() for the same $ATTRIBUTE_LIST fake
> inode. VFS then finds the I_FREEING inode and waits for eviction to finis=
h,
> but the current task is still inside that eviction path, causing a
> self-deadlock in find_inode().
>
> Fix this by mirroring the teardown guard used by __ntfs_write_inode():
> once SB_ACTIVE has been cleared, do not try to iget the attribute-list fa=
ke inode.
> Return -EIO so teardown aborts the update instead of waiting on the inode=
 it is evicting.
>
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/AB8D5E603E6EA856+ae5f622a-dd3a-4e38-b=
dd2-42276ae0e1a8@smail.nju.edu.cn/
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.5
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
