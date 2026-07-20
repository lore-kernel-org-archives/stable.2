Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F4A419309;
	Mon, 20 Jul 2026 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551229; cv=none; b=fNRef0MGgqcN7owiQJJV7GioGTtQxoPbXN2V6P0U8byGfDGtTsy2JIDWh0qcq5sEusUaNeOyni96r5et+agqnEpEdGhqclqv1wGLzbGLfAC+On1ePzh+n7jEwokKFGNcTbkU/SWKasDU17hYXKIdOHeNYc+QCIawefLQH+9yVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551229; c=relaxed/simple;
	bh=+Cmv+ibbGaHqbmFp4DK6NU/RMqv3p9IzAGf7vvtFqoM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PqqdhjApm/mpWcN2WNYI+aINygU5e59/L9rJR2LEVL7G34EJos1ENEQCsNjzDy/m3xXuQy77fSQoj5Bc0DQX4o3mrwdgVHT9r3Ji+nxWDHJPX/ZreeHKCP0X53GSfxKYjD0kO0jhrIIjYc/5bxDBaTB/0CnbcjqwrSVEPlvoNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecxIasuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecxIasuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54A81F000E9;
	Mon, 20 Jul 2026 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784551227;
	bh=6gSJYyG5tqoS/xfJ/ocf6PHpv571KSG20n/AuJPymfo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ecxIasuA0P8PpS9EavsmRZ74Bo1ipvZL31wrcSQpUaUWw8cpPGkk40TmYO+yO9DlY
	 M/msTR4My1TuHQhB3uUJGRqHQFYThOHMHJNo1Oc/2kNm5gkE8gvw1rAaDlvDgP4ILp
	 8TxD9gB7yxMUu0ge2JqO/zTc7mYK0iKRnDHXQMYMcySe0zCXVMD+5N13HD2nIgULqf
	 mY7N9+E8n5m/+e5eBzGLcuIJ/brp7rdgPRcQWOyMhKHnI1fsOw0cLSLEKPlSZ3zTOd
	 DSbo1DAhRH15t/cLxwMc79K1Fo/lqPC3FzpbJxFs1XNKwgTqB2nIg68/ZCdY3cf4j5
	 Y9eBlBJISLlBA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-mm@kvack.org, bpf@vger.kernel.org, jannh@google.com, 
 mail@johnericson.me, stable@vger.kernel.org
In-Reply-To: <20260720-beglichen-kognitiv-organismus-5e1e55326c56@brauner>
References: <20260720-beglichen-kognitiv-organismus-5e1e55326c56@brauner>
Subject: Re: [PATCH] binfmt_misc: set have_execfd only once the interpreter
 is opened
Message-Id: <20260720-atemschutz-kaufanreiz-bezaubern-ba50b64e6eda@brauner>
Date: Mon, 20 Jul 2026 14:39:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+Cmv+ibbGaHqbmFp4DK6NU/RMqv3p9IzAGf7vvtFqoM=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGpeFzigvU9VQJeNJJWZJLdTmcBRaJNg56EYC+1uIDhtNA2MS
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmpeFzgACgkQkcYbwGV43KJ3ZgEAjybq
 L1I5/9t8lCZCgjKwIWelalu/62YFIKz6ujfc6vIBALyCtTQh2A0vT/iAZK6JWds3c8MVq0f0Oar
 VPQj3vKoJ
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 20 Jul 2026 14:36:49 +0200, Christian Brauner wrote:
> binfmt_misc: set have_execfd only once the interpreter is opened

Moving this into vfs.fixes.

---

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

[1/1] binfmt_misc: set have_execfd only once the interpreter is opened
      https://git.kernel.org/vfs/vfs/c/d1e8308f6a1c

