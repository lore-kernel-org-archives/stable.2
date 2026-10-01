Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994751DE0B;
	Thu,  1 Oct 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864997; cv=none; b=baIXXuyaWE9G7DuG9u3Sj1z0SmNrRchGro5zBb4QQFIQ4u6EZNCWjM1D+M2hrXxxl7DZA9OY8WJIv1aS3tQFvKRccfFtOct5yJ7wBMuR4cGZuNQMayn7JIwheUT20S+KMiVmQ7VxaF4tsz+Dn0BWEeaSUnkf/i7HcJIqR4hwmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864997; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqeZ86c23o7k3/GlxLIZcOmil1R9dCuEZ3nHbCu6k/h7jWB3Ainf8cwj/bt6psZy2ru80wlDLBW8dr2i62T5LvTcAILmi4gBQOycIbV7OHqX0T1p2ccl1P2XWxzJYQUzpDL/ewsndx5J67wqah03+TherMr7yZbnjFRCZUCeM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUBlXWVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUBlXWVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00B21F000FF;
	Thu,  1 Oct 2026 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790864988;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUBlXWVFUnIx2HW1hDZ0zIvSaolZ46UIbJBWeI7bUCyAkCBKYdyb/uUsG4Gfs0PAK
	 SMq40164ELEO+huMmldqrANnHTuOWqOxrb5l4nuiG/eB5xZVQVm9Rs/OB8XXWgEnZE
	 jUkld9bczAB09Gy1ANeu1J/RckV04fPY3VYr4OtDzEAJsjh9Zi5HhTEo3xp26RaU/1
	 PSyNLcxQO/VWBTI3E7XzWvlZH47VuQLSa3L9aAoYvq2vmdgp0WJZCSQXwn1/56a+m6
	 Nky10fCx7zDZmD9/A3lfhRCrw4zDACKf+vm/5Ey7OIVYZUqZctndE4uZKROrtrRJk+
	 10jw89dCE5Gng==
From: netdev-bot+sinfo@kernel.org
To: Vaibhav Nagare <vnagare@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 nagarevaibhav@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net v3] bnxt_en: don't leave an XDP program installed when
 the open fails
Date: Thu, 01 Oct 2026 14:29:47 +0000
Message-ID: <179086498718.31693.17965489169136588903@kernel.org>
In-Reply-To: <20261001142516.1386525-1-vnagare@redhat.com>
References: <20261001142516.1386525-1-vnagare@redhat.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
