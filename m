Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373B43079F
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455713; cv=none; b=mJxydpNxk2TDgW264wY1fJe32/QkGnr+X8uHeoPOMk4A9tbfxBpR3mxcHhPkJuWEdWLtcZ+erv/Vh+DZAomfLQTHPvfMuKMU7f+0Br7E/x6y76TfHlCeTWJjmPmIP45yNjynIcKx8l5R0mwCQhRieZVIm6qQKvQDbSt5BtdvwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455713; c=relaxed/simple;
	bh=56fdv0bYKjII6yipuNOi7ufXtekYm6n4taI9qFvPUZA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oPUMplC3+qf0MWx+Qx9Wes+NL8XDVAOUwFTlEa1FWIKr+dxwdw7yxk+olpHYyiSPmCHF0Qun0JI+8FVzDFzgbvuA7TTMmp3O6bkYMMKtUIGa0kbtQlLTlAD8eajtrgVQVW+4ajL3QFaV5C337r3p6Yx7NN1AHYq8uiagyajzjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rfc2549.ca; spf=pass smtp.mailfrom=rfc2549.ca; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rfc2549.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rfc2549.ca
Date: Tue, 11 Aug 2026 13:41:37 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: "IP over Parrots (with QoS)" <opensource@rfc2549.ca>
Cc: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: 6.1.y status: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available") / CVE-2026-64561
Message-ID: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
Feedback-ID: 126047231:user:proton
X-Pm-Message-ID: dafd38a5c9408fff92b32ba9e581b0af0362d390
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Commit 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root
*after* making MMU pages available"), which landed in 7.2-rc5 and is
tracked as CVE-2026-64561, does not appear to be present in
linux-6.1.y as of 6.1.182.

I checked with:

  git log --oneline origin/linux-6.1.y --grep=3D'invalid/obsolete root'
  git log --oneline origin/linux-6.1.y --grep=3D'2abd5287f083'

Neither returns a match and it doesn't seem to be in the queue.
The commit message notes the invariant being violated was
introduced in 5.9 by f95eec9bed76, so 6.1 looks in scope,
and both hunks sit in direct_page_fault() and FNAME(page_fault)(),
which appear structurally unchanged on that branch.

However the announcement[0] only mentions the fix landing in:
- 6.6.148
- 6.12.101
- 6.18.42
- 7.1.6
- 7.2-rc2

Is a 6.1.y backport planned, or was it skipped deliberately?
The security tracker [1] for the Debian 12 stable kernel (6.1.y)
shows a vulnerable status.

I do not have a backport to offer, so this is just an inquiry.
I am happy to build and test a candidate on 6.1 if that would
be useful.

Thanks,

David Moreau-Simard

[0]: https://lore.kernel.org/linux-cve-announce/2026080401-CVE-2026-64561-d=
0d4@gregkh/T
[1]: https://security-tracker.debian.org/tracker/CVE-2026-64561
