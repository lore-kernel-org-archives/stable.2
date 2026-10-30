Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377085;
	b=E4rcz/85jlCWvPv4nWu1H9Ko3FnJCF3ZD8xbnOLjuwJJt1SPEMQjZWB7EYM2QmOfi8tc
	 HlHFqcsM6kF+2mnxcbeX9QFYgpELsUvrwzt6a03n0hCSS+46UiyRRwHf8LNv67oKCzLOm
	 jkAvC/U6R/5M3xunRQPuXoEFAkkwgu4fh3ffbMYvvRZF7HtMzF3xeBcb3gSeKEh+9DWSD
	 aY69c9bRYwXpw8+B1yEMWDsxeCzzhVfPhICRL+csS8SqE/D9tA9HqQUf0sfwx9fZy3fp3
	 wafdEnunj+GoMXq9VYSPvBiYasZgpDzuNbTI4o6eYwG4wCWd/1Hj9zXXPblD4vmrQMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377085;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=ZDNHG8v8zk9WmJP9GH0iqpZHJN79nd4ttmjK0fCFWyk=;
	b=g+oShhIcx4+U1ExFeVr5j6GsJYo/5175aWY+N0Qql8HHioXVHRwHEe3iC84M4dfssZda
	 obYJcr917EMqxlx8qpQK2gz6Zg5gbf8u7+NRPVn+gQRKKkC8jFP8TDYs66i/b3FVd6OOU
	 lkvemoU/loolHnqTI8unhr/CfvAuZl5x0EOfZ/eoGX4/i64ACe/9adlGB46m0abNEI9qz
	 DmPAq0jZQF447eAu80uooril0wVtnabXyr1Px44juFCSIu7WFcAYsP6yymM0vRlMsXjCz
	 YohpH8YBaKYFUXPqp0Z7xwbc+qQE9YZzTh+sMbj0g4yHl9vqfhYqGu9+Lvj9pjBAPeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWb9BuFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F3606A31C;
	Fri, 30 Oct 2026 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWb9BuFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BF71F000C1;
	Fri, 30 Oct 2026 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793377084;
	bh=ZDNHG8v8zk9WmJP9GH0iqpZHJN79nd4ttmjK0fCFWyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eWb9BuFdkxI1AoMZhA1RbZq7J/sUlQ18FiCmi5ShQw/WYHUb+y+CeSsSuuZqY26lW
	 1/nv4TeLqKesyblsRXZpbD+xxPtpMZj5VfWLthnZjuelUmKZlEQu6WEnqvU/yEuZPG
	 aJx/6bdO3sgrCSwaR2sTbIj1xu8miLdFRL6KAq72+SLi9OtLq3ycFHm/W1+MWoETdf
	 BiZ2FQ8ok2GAmsmOv+By3+V63Vc88VU4ZRLqt/IvLJTXfIcpn8LAi97b1WifL7prbi
	 9YPywOmhwxgnttRnNAMgV7KKwYeJOg7i6Zynast3R7X0DeM7v3UVU1gEpneK8Op02b
	 N5ACo2z7m2LwA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 kernel test robot <yi1.lai@intel.com>, stable@vger.kernel.org
In-Reply-To: <20261030-work-nsfs-init_ns_tree-v1-1-7ec0adb47c54@kernel.org>
References: <20261030-work-nsfs-init_ns_tree-v1-1-7ec0adb47c54@kernel.org>
Subject: Re: [PATCH] ns: don't add init_ipc_ns and init_net without
 namespace support
Message-Id: <20261030-labil-bergab-besetzen-9a2b7d8d71ac@brauner>
Date: Fri, 30 Oct 2026 17:18:01 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Fri, 30 Oct 2026 16:50:07 +0100, Christian Brauner wrote:
> When CONFIG_IPC_NS or CONFIG_NET_NS are turned off we still add the
> initial ipc and network namespace to the namespace trees. ipc_ns_init()
> calls ns_tree_add(&init_ipc_ns) whenever CONFIG_SYSVIPC is set and
> setup_net() calls ns_tree_add_raw() on init_net whenever CONFIG_NET is
> set.
> 
> But without CONFIG_IPC_NS and CONFIG_NET_NS these aren't namespaces
> userspace can do anything with. They don't have proc_ns_operations so
> there's no /proc/<pid>/ns/{ipc,net} for them, nsfs_fh_to_dentry()
> refuses them with -EOPNOTSUPP, and since ns->ops is NULL
> __ns_tree_add_raw() doesn't add them to the owner list of init_user_ns
> either. So they end up half registered. That's also not how we treat
> any of the other namespace types. Without CONFIG_UTS_NS, CONFIG_PID_NS,
> CONFIG_TIME_NS or CONFIG_USER_NS the initial namespace is never added
> to the tree.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] ns: don't add init_ipc_ns and init_net without namespace support
      https://git.kernel.org/vfs/vfs/c/82f1c815aaef

