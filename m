Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88E4963A5;
	Thu, 23 Jul 2026 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813384; cv=none; b=QRVPSLltxygIutB+ViVI14uhjITzrBYOPmmhH+T7XztjppOCt4bXjhFaT7Pvt3/9+98uV/nX2s5Fx3CWfiwqXa23QGFwN+qnsnPwSUuZOEaXwCy0+Sxrjficq7FdTBFF6ZkeVYWZ4cjBzJKUElWQxsVQRfwdd0C4PbLW3LH1ZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813384; c=relaxed/simple;
	bh=jlS1CQ2CImc0/y+01v6Hb1rpC0YyyEIywGqsUrLzmb4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=D5vzvcyu0UN2346gm3DQpGizDBNkOnE/w7xKmWLkuHwT39QuWluSIHoLpfiwC0SGwJpiCkuyjobcIWmThqW1WL1M65pxE68Cohh61g6UPsIyJKuekkiCB1PxJHYorwqI3cJa9bDGVA2BpXxU7utzhxuJR7smdsdCQYd2t+0o1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O344mY24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O344mY24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2981F000E9;
	Thu, 23 Jul 2026 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784813382;
	bh=/eJaksA8cVR2h2DWYNLQWK0/asNQiai/rebHD8qgg1s=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=O344mY24di77hY1DpoQTGBaL/uH0bJpdD7FKCI+mrUNk5Z/tPe856FQFGZv5jHEo2
	 YZrPy38475ITtvSH9z7qFZHirUWRYzIvK+R1DvxD+ttwMVs7K3jL86l2TMuM+C+/MX
	 abg/gN9vXhAV03N8eiV3vl9QtPAw57YMniITd1xsqAfSYgqKsNzyUh0BD3eXHF7Cv0
	 FJz/82jygREDLtA75V1NGDD5GGF6MvxxyZ2jqQmRdyVZFOJUKVrAM6frEHeVf7WQ6f
	 MsXHyBReFNy8ZaoJ9NwRXYhf0h6C98p1jzLU4gzMA6/2Rh88OiiKS21Gi+i0MxLN3z
	 v9odJn6VK0Rig==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] binfmt_elf_fdpic: only honour the first PT_INTERP
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me, stable@vger.kernel.org
In-Reply-To: <202607222110.D5AB43796@keescook>
References: <20260721-gezittert-medium-kreide-b41fc1f0277e@brauner>
 <202607222110.D5AB43796@keescook>
Date: Thu, 23 Jul 2026 15:29:36 +0200
Message-Id: <20260723-ertrinken-ahnung-pizza-5aac875268d0@brauner>
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jlS1CQ2CImc0/y+01v6Hb1rpC0YyyEIywGqsUrLzmb4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQliTtd+ryyUa5mVdSS0JZpdlPsDbN+6byVj5N8uGN2S
 OGpU7e1O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayJpaR4d780AUGn2QcPxed
 72IoDGF79Zy7YNGzXpkTtwVzvl23uc/IcCqSU/X6pZ0KN8WTK2Z/Xrf/chb3hknzYi+Y8e7PUkh
 dyAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-22 21:13 -0700, Kees Cook wrote:
> On Tue, Jul 21, 2026 at 01:20:45PM +0200, Christian Brauner wrote:
> > The program header scan handles PT_INTERP from a switch nested in the
> > scan loop, so its break leaves the switch and not the loop. A binary
> > carrying more than one PT_INTERP runs the case again and overwrites both
> > interpreter_name and interpreter. The previous name allocation leaks and
> > so does the previous interpreter reference, along with the write denial
> > open_exec() took on it. The denial is never released, so the file stays
> > unwritable for as long as the system runs.
> > 
> > An unprivileged caller reaches this with a crafted binary and repeats it
> > at will. binfmt_elf stops at the first PT_INTERP. Do the same here.
> 
> binfmt_elf ignores all the other PT_INTERPs, which is what you've done
> here too, but I wonder if it might be reasonable to refuse to load such
> a binary?

As a follow-up change I think it might make sense to try to do that for
both going forward. As an actual fix this seems safer.

