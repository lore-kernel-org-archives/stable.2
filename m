Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514066;
	b=PVYxjJ6nJRt4OfuUX6ZMg3GUAhs+0IEMP5hLwl5oGXraZSx2+gnxKiqeEoms2pcOgg1x
	 p7AwPsxjIDsamo34nfcQhmehlZLQcVd93tJKJ6cA53KTwqNV2NkvUisHRDXXD1jl7SErx
	 nBr6uBvLk2X+JiXqH+m2rz/7QVC46LP+XfbKh5leM61GCrqHli4befl8ndDZq1VF11ODm
	 8AJFXvP2ceg7xWYE5HaIi1e/3Dfi1WxvVcS/DLXEPd4YE77hqEbPp0/m/Kg2lrGjPaMWW
	 L1u0VxmwHpfJeu9V+EHqU7OzyZv8g1LwwwFaMdDRlku+IePdt+AQoYe2D1aljn7wf7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=R4rFUyAMG2Pjo1H5Ntk16BK+VJ/lrAEYbf1wHbavTgc=;
	b=Ycs9CSBICs7AGp4C9USINKzcUbAYU2w+AabD0noX58XxuoYorgwO/euPbpB3V6EkbeWE
	 ixZ2H+00WAnBHQG1HfO8aIdIF9S4yW8D2/NEjqshJnuEYjR2zLkM+8sln1UCttuHW1qGH
	 MeIDEk3FIbky2Zsvwy3eEjWTgnZL4clCIDTvVRw0VYgrjCp0D5l/AUjJdaN0dVMvMHfD2
	 QiebhA95FOFRy9VjJgapkgcKW4jb4oiT54EtZx4+svBPdZAUqZItWZbq3FSPJ2uYbI++p
	 CBbT5kAUeZ8xt86RcQcafldLrOTPZ73rZUdbH0r0F8Gx/j3DMwurQjxbQbU8waXYSoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cnv4XtzR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A0606A31A;
	Tue, 20 Oct 2026 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cnv4XtzR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A11F000C4;
	Tue, 20 Oct 2026 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792514066;
	bh=R4rFUyAMG2Pjo1H5Ntk16BK+VJ/lrAEYbf1wHbavTgc=;
	h=From:To:Cc:Subject:Date;
	b=Cnv4XtzRJ1B6fhJEL8Hl+Q8acNnqXyRMW18cYtPMa3LJHtd6dBCADNBsnG2KqtEuX
	 WeRVxwtmZBnm52QW5iKwrdfL49DWqgfNGdmpHuoebvg8ULgIDAwMI9RvhcGPtTNqyg
	 NOwYBisouxyttgwH8CBbBD9o6JLmXIpiVkhDSROmoGJgaCmrVL7CP/jYF4exK11ZMF
	 Xs74xcMqPzoXFmTVISxfBARrh5yIPROcEgGXyMNEwQPnAugymASVzTxWD8cCrz619l
	 +uEzR7StPOuTzP+8f0eKAhYISKjglOy0HTmoXplElr6PHpQHYgOTsovctbnKLU4W2i
	 InLfJNxRoV7Aw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: stable@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] docs: stable-kernel-rules: mention Rust soundness issues
Date: Tue, 20 Oct 2026 18:33:58 +0200
Message-ID: <20261020163358.176088-1-ojeda@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Back in 2023 I asked the stable kernel team whether we could consider
Rust soundness issues for backporting, since we wanted to be able to
protect (as much as possible) downstream users of stable kernels.

Since then, we have been doing our best to backport patches for Rust
soundness issues.

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
As requested, here is the following embedded patch as an independent
thread:

  https://lore.kernel.org/all/20261016160030.118973-1-ojeda@kernel.org/

I added a small paragraph above to make it clear it is what we have been
doing in practice since then.

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

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
--
2.56.0
