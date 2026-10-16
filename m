Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2CD4E13FB;
	Fri, 16 Oct 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166442; cv=none; b=QNTb6mR30JSRRrSl5n9C7o2TTQS7004ccJBiOcQ2toC1R6syqGDv+eIjHGRaOUHNaJPc9vqgX/9fI907t69q8mOE3HDriZ0XKn6ltiV4cLThpm8+gvT1PS8kZ586+lyp+o9OngPCHruywFjbduCkuW7PcwCLxv+fh0Oto9H+yLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166442; c=relaxed/simple;
	bh=cwJ4kyMa6Gkqn0iBbnm4SEx0O7WXMFKZxOGHTpFegy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZrrTjT9S3vNrvrTlAaMyMbNhLRHLTqvUSzaiokwUfv1c5myWhFpuZQDScDWbWsKXw2K0ajHbQjbNalw/IaDEgMk/9jgP3EZrUUz9VDCE4AqX0kt3ftoIsMIlEwfUxJLjHsy35fMz4JPARr50sl/dfW4R7URffuyL2ZKTrV3uyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYnYeraJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYnYeraJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77B71F000C4;
	Fri, 16 Oct 2026 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166441;
	bh=yJXeZcV7JARoUf8IyMfjJh3a/u/usVAGSPc5Xd4jqHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dYnYeraJz4PZPpiB0OdvFYkLIMvXPUzWTAzb8KZfjoKzDYN5IKyxH+6O4zERFiQSZ
	 4SGckvfoXukoBqd8cRtyHLcQcYNGiR+hVuXhkwNhJv6+WS1w3NBxQ3hgPRI8Hjhojm
	 TIOA1C4smAWrJlrAEkyhES+ksEMi6Mq9NtNz0i+M3ammEk/T5lrqVYxkyb96f91VIB
	 qEQbeVqMnCsfV4YxKsSS7wcvqBwcLlqDmgGox1N3oUEzoolAy+IWXLGgjtXioB1yoZ
	 YuTIbzdjYDWvaJvtNHLk7Vrl4AZQoaw0oEynAjen7VMaYz0MQzgpY1lP6lX8QTitBV
	 PcEVAdTZEUrNA==
From: Miguel Ojeda <ojeda@kernel.org>
To: sashal@kernel.org
Cc: broonie@kernel.org,
	corbet@lwn.net,
	error27@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	kees@kernel.org,
	konstantin@linuxfoundation.org,
	ksummit@lists.linux.dev,
	laurent.pinchart@ideasonboard.com,
	leon@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@leemhuis.info,
	mst@redhat.com,
	ojeda@kernel.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	tytso@mit.edu,
	workflows@vger.kernel.org
Subject: Re: [PATCH v3 0/7] agents: add skills for Fixes tags, stable tags, similar bugs, and commit messages
Date: Fri, 16 Oct 2026 18:00:30 +0200
Message-ID: <20261016160030.118973-1-ojeda@kernel.org>
In-Reply-To: <20261016152828.3765695-1-sashal@kernel.org>
References: <20261016152828.3765695-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Oct 2026 11:28:20 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
> Changes since v2:
>  - Keep the skills in agents/. They are now short pointers into
>    Documentation/ rather than documentation of their own; see the
>    discussion on v1 [3].
>  - Cut each skill to a single short SKILL.md that points at the existing
>    documentation, and drop the git how-to (Kees). The skill text went
>    from about 960 lines to 250.

Thanks for both of these -- it does seem simpler to me this way, which
is what I expected.

>  - Drop the 100 line limit and the exclusion of theoretical issues from
>    stable-kernel-rules.rst, and require a fix to be correct rather than
>    obviously correct.

If we are going to have a skill for the stable bit and you are updating
the list, then may we take the chance to include Rust soundness issue?
Please see below.

Thanks!

Cheers,
Miguel

From c2459728a744144a592b45b5b8b807c0f15b8608 Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Fri, 16 Oct 2026 17:37:25 +0200
Subject: [PATCH] docs: stable-kernel-rules: mention Rust soundness issues

Back in 2023 I asked the stable kernel team whether we could consider
Rust soundness issues for backporting, since we wanted to be able to
protect (as much as possible) downstream users of stable kernels.

After the Rust experiment ended, I documented it in the "Submit checklist
addendum" in our "Subsystem Profile document" [1] (i.e. `P:` entry in
`MAINTAINERS`):

    #### Soundness issues and backporting

    In general, fixes for Rust soundness issues should be marked for
    backport, unless there is a reason not to (such as situations where
    the backport may require a lot of effort but the risk of users
    hitting UB is low).

    For context, while the stable kernel rules mention "theoretical
    issues" should not be backported (which one could argue Rust soundness
    issues are if no existing users hit UB), we discussed the topic of
    Rust soundness issues with the stable team and decided that we would
    do our best to backport them.

    The goal is to help to prevent actual issues for downstream users,
    distributions and vendors that patch the kernel further or even
    add completely new code on top, since those modifications could
    hit UB. In other words, the idea is to maintain the "extra layer"
    of protection in stable kernels too, as much as reasonably possible.

Thus make it clearer by briefly mentioning it as well in the stable
kernel rules.

Link: https://rust-for-linux.com/contributing#soundness-issues-and-backporting [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/process/stable-kernel-rules.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index edf90bbe30f4..ffa7905543a6 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -17,7 +17,7 @@ Rules on what kind of patches are accepted, and which ones are not, into the

   - It fixes a problem like an oops, a hang, data corruption, a real security
     issue, a hardware quirk, a build error (but not for things marked
-    CONFIG_BROKEN), or some "oh, that's not good" issue.
+    CONFIG_BROKEN), a Rust soundness issue, or some "oh, that's not good" issue.
   - Serious issues as reported by a user of a distribution kernel may also
     be considered if they fix a notable performance or interactivity issue.
     As these fixes are not as obvious and have a higher risk of a subtle

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
--
2.56.0
