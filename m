Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=147.229.8.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556478;
	b=LmoRT2ccFizxqgO8259NGdYVo6pJMsFIWP6XSpGBTQsFJ2IwAZUt/8OMHXAxkR2uC/7B
	 09CJovv99jtA/E22ouuzK7YOJfV8vGZTl1aqJTH7Ce0p2a9KVcuMj8YdFO1Jc9z1rBONG
	 xYZktBZMffChiDPFuURUhmM2VUD9CPBKiKA7+IaKAaGiJpMspdep4QwdLTnSqL478YyJs
	 yGHm5XcSqALyvDM2rkztAicMJmYajBwcNuZLxs/G4hg0rr2iUcBtf0SkWmUUgtFisP44s
	 GBodbmRvkheEgy/DCBeHc1KmLDtszYZk8LH7IM8jZTPPOd2d9k6dPcU2fscz3NXnPCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556478;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=JFkV9bS+mP1vS5f3erLfexbBA3iVAFLmlh9l+XmII+A=;
	b=rQJxHy6RQKSjzL4K00cvV0nC/P4ndslTMk3QfJsgziPg2LGL9E3/9q3r7l86A7jISWu6
	 Una//Dh61J/KVa+e9SdraSvW/v/ArlKxaCiqX3AAAzk2xSJkTM/4otjX1rQ+uWIi/I3gZ
	 g+BJg4jnyHEcg2AwCpg3idUlwAjm2Orta4PrW6ruoV6uWAlf3DLomkazSwq91yzkZepne
	 SNgVR1n+2K0x8pAxZGPwdjQTrgFPiYKkcRLssew6dpFqEx5PADbaPjM9P3m1MSfMrQijN
	 K2KtNyAa123vgXZTqFYJzMbMiWLuouaUn+kCT08k3un12DOS09IgayuzSKWAarcp0QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fit.vut.cz;
	spf=pass smtp.mailfrom=fit.vut.cz;
	dkim=pass header.d=fit.vut.cz header.i=@fit.vut.cz header.a=rsa-sha256 header.s=a2025 header.b=PzTFvfpQ;
	arc=none smtp.remote-ip=147.229.8.13
Received: from adela.fit.vutbr.cz (adela.fit.vutbr.cz [147.229.8.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC72606A31E;
	Tue, 24 Nov 2026 21:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC72606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fit.vut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fit.vut.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fit.vut.cz header.i=@fit.vut.cz header.a=rsa-sha256 header.s=a2025 header.b=PzTFvfpQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fit.vut.cz; s=a2025;
	t=1795556474; bh=JFkV9bS+mP1vS5f3erLfexbBA3iVAFLmlh9l+XmII+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PzTFvfpQ2nZKR0AdCY2mJeaOL3S3u7fphgL252imlmM4YG7hmk9kOhVikZc+++RcE
	 kwOpgEAM5XXI02gggupvkxjjlOmz11Lcwo+BQnRIijFYut0Iy0rcfJVAxLcJdyfj4c
	 k+fQclWG3YnFPq9hoK3c1fa4s2jkPD/DLjN0SiaYVZqfvdQpN9wGiY4O50GJpRvG32
	 fFuDJTnMxnjPkAyuiGMYwJEv4EWZHZkLSHbP42gXjQQic4mm6aRolXtxixRdZXtobo
	 ziSSoTQe9q5/p6lwdtIKbB6Coa9aNgs3XOOYCpsqBSXQfkfT90wo/S/dci50hKOX+o
	 RF0o400SSlFoQ==
Received: from tomoka (unknown [100.72.76.61])
	(Authenticated sender: inguyen)
	by adela.fit.vutbr.cz (Postfix) with ESMTPSA id 6A4B1260127;
	Tue, 24 Nov 2026 22:41:14 +0100 (CET)
From: Nguyen Le Duy <inguyen@fit.vut.cz>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Nguyen Le Duy <inguyen@fit.vut.cz>,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	brauner@kernel.org,
	cmllamas@google.com,
	ojeda@kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust_binder: only remove a node from the tree if it is still there
Date: Tue, 24 Nov 2026 22:39:36 +0100
Message-ID: <20261124213936.3708259-1-inguyen@fit.vut.cz>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124121328.3253693-1-aliceryhl@google.com>
References: <20261122191322.929005-1-inguyen@fit.vut.cz> <20261124121328.3253693-1-aliceryhl@google.com>
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
X-Virus-Scanned: clamav-milter 1.4.6 at adela
X-Virus-Status: Clean

(Resending with everyone in Cc. My first reply went only to Alice by mistake...)

On Tue, Nov 24, 2026 at 12:13:27PM +0000, Alice Ryhl wrote:
> Nice catch, thanks for tracking this down!
>
> Instead of still running `do_work_locked()` on a node that was already
> deleted and checking the tree in `remove_node()`, perhaps `Node::do_work()`
> should simply be a no-op if the node has been deleted?
>
> If we track `is_deleted: bool` in `NodeInner` (set when `do_work_locked()`
> removes the node from `ProcessInner::nodes`), then when the stale `Node`
> work item later runs `Node::do_work()`, it can clear the `delivery_state`
> flags and return `Ok(true)` early without entering `do_work_locked()` or
> touching `nodes` at all (and `Node::cancel()` can skip re-queueing a
> deleted node as well).
>
> Since `do_work_locked()` only removes the node when `active_inc_refs == 0`
> and `!weak`, any required `BR_RELEASE`/`BR_DECREFS` was already sent when
> the node was deleted, and no new references can be acquired afterward.
>
> What do you think?

Thank you for the review. I agree that this way is cleaner. I have sent a v2 that does it this way, with a Suggested-by tag for you.

There are two details in the patch, in case you see them differently:
- `Node::cancel()` also clears the three delivery_state flags of a deleted node before it drops the work item, as `Node::do_work()` does. Otherwise has_pushed_node would stay set without a work item behind it.
- `NodeWrapper::do_work()` has no `is_deleted` check. `Node::do_work()` does not delete the node while the wrapper is queued, and a wrapper that deletes the node is no longer queued itself, so a wrapper never runs for a deleted node.

I checked again with the Kani harnesses that found the bug, and with the reproducer in QEMU. No problems were found.

Thanks,
Nguyen Le Duy
