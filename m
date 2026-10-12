Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3743CEF7;
	Mon, 12 Oct 2026 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796916; cv=none; b=LdjATBKIsah7JGKFMZxKaqNNymy8f3QWPIGXe4s4tGeURJJl/qmgJdxh2KL/oUHUYX/QVa2Spqm/3WioktvoilUypT/HBIH/YQLcSCp2T3NklivFReZ8T+eeBou4onsRxqHcAiD7HFHBI6jqRbhlj0XCHEOfFxJmhc8WMas17IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796916; c=relaxed/simple;
	bh=6f3HJw63bCvW4/pIKwU8wj8+PAGOPGmFZFBiErtgAU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SH2uo/CaPgsTaAojNgssp1//1sa03X1t6qUXIL9gxUNf+sWoJoMzypD+hG3KKEM84epZ2bm+2UKR9jBW6NcjaArTfWUUNvArYIFon0a6lBhxbG2Z1d4a6l04nq2ZO+u561/lilTo/6RO8TrPLutFVKQqGtQ4Zdv7AZAil54IpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmN4FXht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmN4FXht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBCB1F0089B;
	Mon, 12 Oct 2026 09:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791796915;
	bh=4oEf2wAnf0mETCtZw9G8f28F1g5F48JNocaZq+Rl0ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DmN4FXhtjNKZfHEifo8HnOr6yeJZ7qVqAr9AYDkIrNsJtAcwd0Z6e7j7lQzg8TawC
	 PJuiKaVwC6aPqHZK/BZ7QhrnXJTFPsXa+U+qb+0OmhEMEtuq+ff/ywCjknPMWzP+TX
	 4RkeOHjUvHjVqJJoSlED8Qr3BrGvfzcoIZ6LiWfAMSEX9CgBX8VNGEb/Wmz9D9Stu4
	 AyOhSrH24vCrWj36mVfPG3wPwp9cZmXQGqJnARW7AU9r1GEFWGW6DCdH9MeKhJTiTV
	 FveirNayGSctxSDPMo25o1HaVmrwemFokHaDdSLhn4kSceqUvairGTiZQaP4xkmHdb
	 KkMMUBSuUmkWA==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Aviv Vaknin <vaknins33@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, 
 Bradley Morgan <brads@mainlining.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261002202820.3433318-1-vaknins33@gmail.com>
References: <20261002202820.3433318-1-vaknins33@gmail.com>
Subject: Re: [PATCH v2] pid_namespace: make zap_pid_ns_processes()
 freezable
Message-Id: <20261012-abwickeln-lerngruppen-anekdote-47c586bd5073@brauner>
Date: Mon, 12 Oct 2026 11:21:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8

On Fri, 02 Oct 2026 23:28:20 +0300, Aviv Vaknin wrote:
> When the init of a pid namespace exits, zap_pid_ns_processes() waits
> until all other pids in the namespace are freed. A tracer outside the
> namespace that does not reap its traced zombies keeps those pids
> allocated, so this wait has no upper bound, and while it lasts every
> suspend attempt fails:
> 
>   Freezing user space processes failed after 20.006 seconds (2 tasks refusing to freeze, wq_busy=0):
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

[1/1] pid_namespace: make zap_pid_ns_processes() freezable
      https://git.kernel.org/vfs/vfs/c/23194f382636

