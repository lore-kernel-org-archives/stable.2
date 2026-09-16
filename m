Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6480C3769E8;
	Wed, 16 Sep 2026 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523553; cv=none; b=IgelERf5Jaagtf2ad3VjogoLwLjrCdCoC+x+q8PEGjJfAlVXPa5QlEFWthy6+dMSwuyV13QNh8pmjDes/n7zMdThSju00LKPvpMct0IwTzXW+23whULrDJr0AYm3zYBJXE5+iGcIWDRceZBjuvbF+nMAiiStgN1apZKi1mnBnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523553; c=relaxed/simple;
	bh=3bCDk9sTfNVbpPCE/XoEkPyCPGaah2mAPqcTMpZ8Dvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPXb4MfZHfX79JGI9xkAw4VXuI7twXgvkhFmks8LfCmHJWdbqhRHXVnAV2PbK21q8PPp34XS8Y/WeV5IsEiqc6TQkfSiTN461s2RPAgG7NZL/nA8g2VsnjRpqZdEgzSiqcht/xnE4cNQJooSPV/EBkMHhI6ClUtCBTXA2hSkpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioEyMJF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioEyMJF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A9F1F000FF;
	Wed, 16 Sep 2026 01:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523541;
	bh=vdrdBjWTvsZNXTVui2WucyGiZG4Bik57Fez2TRhq+QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ioEyMJF5TUkmetU7i5qKwsxS1jqo6CJz3tOGQbzRsK6nVtZSUPshE0IrZFf1Hx9NQ
	 jbJp4sNV1ONj27RR1DqBeNS6ZBJ9oo3EeUtEU1BQpPVHu/Vo+q7cVm0i4i22sdqjyU
	 coDKC+YCraxvO6dENvLUjgfwVzc/Kvq5Em7qAkj09R+TbquSBhikE1b7NAfvhvqzBi
	 iyVGo8pkpK2QDYhZi/SbwIySnLEDt+u3JL4Qu3zlGyilktF8mDNRZnIYk5WgUIMpF9
	 r3n+4aAMIWDe/xNky/sN4McGyNgUrB4WXLcFeUgAozpza5W9Y0YNx3VDBMS7S3mMxH
	 aTeSUQK1yPqoA==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Block <bblock@linux.ibm.com>,
	stable@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [regression] 'scsi: core: Register sysfs attributes earlier' in 5.15.221 broke booting
Date: Tue, 15 Sep 2026 21:52:06 -0400
Message-ID: <daily-reply-20260915-0001-re-scsi-sysfs-5-15-revert@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4a76bd61-13a2-4010-81b7-bcea325b9c63@leemhuis.info>
References: <4a76bd61-13a2-4010-81b7-bcea325b9c63@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This 5.15.y change according to
> https://bugzilla.kernel.org/show_bug.cgi?id=222016#c5 broke booting on
> sata devices for two people; the second reporter indentified it to be
> the culprit:

I have reverted it on 5.15, together with the rest of the chain it came in
with, so the tree is back to its pre 5.15.221 state for the SCSI core sysfs
registration and smartpqi. 6.1 and newer are unaffected, they carry the
upstream follow-up in their base release.

One consequence worth stating here: this also takes 225548863f0a ("scsi:
smartpqi: Fix AIO retry marker cleared by SCSI core between dispatches.") back
out of 5.15, since that fix is what pulled the chain in. It does not apply on
its own on that tree, so 5.15 needs a purpose built backport before it can
return.

-- 
Thanks,
Sasha
