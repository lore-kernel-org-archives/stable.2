Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98625A655
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645149; cv=pass; b=URaemNacFwvynFkw+01eX7rLL5SQzwUOq1ijLm/BMU/CkJTQAYmKK/YQKLrdwjViuqdpcLQgNbZK6dwVE/HhwjXXj0BCU2ay14iW+hl1U25nsCQatn4R74DyFq5n+0e+sxO0VPfrsDoqZa1MmLet1oGjA0mZWxs9lUcHEckDbbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645149; c=relaxed/simple;
	bh=Cf09x2JHo4oLMV2RRVxxqg7PFh53GRYSH+2+NQzMm5w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nYOBem1xsgqukWyPoJ9MNSgPgomNcb70oydrZwvFCMUPm2t+XP37cEsQ12JroU1dWdzcq9CNxuwHhBUrYnRJvzGGYkU+Amq+CrOBaTOj7eQJsikGhwvFOKfVADp9CA3XzP2LTiaLXwGfvQntyFGL88co1HJ8nfPGFhNLWsqh9Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwU5RYfc; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwU5RYfc"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-85a50f6a7f7so30440437b3.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 14:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788645147; cv=none;
        d=google.com; s=arc-20260327;
        b=mirbLdVpPPaQHv00ib+QMIN2MgIjqTLBLkQS2IFPltPx61J8t6l2KAkvo70WHSk/08
         EH3X9KTbf2YDJla+GPIRdSY5LTExRMwqbQFvLK5Aw1BsfMP1IVekH/oZ8qBRbU0UrxcN
         3dA1bSae89lvVoCSqdngApPtqWLErDSvar1bdGxDFLZ46ffpa+lG3gfMVFz9IrZWJttv
         7lN97AjXPetcg5nBpYkXBH14m6N5GeMLUWk1L8J/j2K++7vODgcZkFT7jmUV0rbUjVIj
         zTfhk68YCVUgUjxFaCDL2K9nN5h/1/+CwGMB4DizTrmaF5qp86dye9QUBvl9Jm+5Nhtd
         +8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Cf09x2JHo4oLMV2RRVxxqg7PFh53GRYSH+2+NQzMm5w=;
        fh=o/IkUFQYSMYiXrWsZzgSVM6Hnq9KMtypStl5M7swnEM=;
        b=ogSOHIfEd5UBWtuyWugAeyomR8mtsdYGOLr/+K6kbVK66WfoAbMV5EY70cNmx3njxa
         poFyHJE+bZp66h/Jbd5x4vT4OapUH5ktaTneMpXGg2cufTtm+R8Ts4y+KoPSeREBCvw0
         wqcSuarGOwP11kdmISxQkZVfU1jDBg+ofaMa3QpDkivUP0v8eEjeAhMvz4uWPsxrF5fp
         SuqLWUd2GnIYr5qdhxR9M7f9VjHhmApFuWO6RnGJeK9RkepThvUpnYL1nXNdoTAUIA4s
         zndgwdcsTsA9kNb/pBMXqLWOO6qJDDheyU+AK59JfOGF3jRQyvLOON3tcqK+HoqZH9DK
         TCSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645147; x=1789249947; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cf09x2JHo4oLMV2RRVxxqg7PFh53GRYSH+2+NQzMm5w=;
        b=QwU5RYfcIli+ZEUubwZ3ZfGjrC54jDH1R7F55NZweIBcxGr2cjrYYTzSsXyXXiPH3t
         B7JvNwkv2qQ4Zp15ZJnfQifnU1m8Gi9iV8Jnu6/ifuxYwEpT2FPACMRiMU6uI5PBcSHr
         S3Ji/YsxHm21v+/CX2PG1nXLXAX9jaVENFDGbzjafu2w5CSI2t1vuTm/X9upzePNkBRB
         UnvOAGFhoVux6cefDXr7B7jLhaMFYEXUQCK3w3XGq6QE2n4NPAjHEGyElyhh5gQBSfsB
         QYlmorZYKAjJHBsUH14e8KdDdmd4uDXVIrniIhJ9wDUqH02LMPJYs3efwJQAWnMN3CuG
         93yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645147; x=1789249947;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cf09x2JHo4oLMV2RRVxxqg7PFh53GRYSH+2+NQzMm5w=;
        b=kaNlRH8kp8IXi2stIVjvOeQ429D9bzb2duvI7XNygAT4NpyP92WFXR/PyJBjmTOFOq
         cvhoUyMtJWcsn7qA4UNH7OKosjUJ3CISMU+8GKi4kxhvO/aYnzy7oyeJ/W/jKp13r1Mp
         F4T+MVbrGsmkH4FrhbcpAtfeXcHUPW9wtSkQJ37BU4yjPeq7LfNwI+DpSCyx5XUdzH1g
         rsvqZJNiERW9mgq3J6+TxZxuVRnIoqlLKui/7IMmjpNtttx3vrRT08kbXLNkLCJkpMpL
         Yr+txy1ZLRdAdxpkDSM2g99LOn9ERGJQY5WTHsH6evpv5ngzQEIvCAVt9iqQI5spJxeI
         w89A==
X-Gm-Message-State: AFuF++kv/2Pfptk/z7kC81UqrJGszAMXsgE5l+pfMekrgRr6jkpGZxn4
	1qULJFg8D9BUcTDub0p8RhTVhiVDcvsHJNwC1a0ChIajYfT937Ti+RVx/c7djv4q8kdpqZrd3fE
	91tmgOFEQsyi14Sa6o3MsuxkE1yLDltJpPgBwuJwBuYD0
X-Gm-Gg: AYBFou1RzCOU/qMg+L6t2SP8be45iyKUsU6slIg1MUioIRod2yKo7uiiYx/IXR5mvKB
	BUPEdUuzhax0hmJAqjOs0vT7r6UA0qgSFooDwu8VZfO3aVVzsdk24/ta36mzMKgXk71x3ndPMz3
	sdx0Zhf2ANtl6V4n7OQ16x1w6tmvCUUihOhkOkdhIw+Gwn/DLaLa71SkofqkdLu9JUamgeKI0We
	8SaTnLKZWA66hhKk/ns2THd9hhp7mk4GbarH5MezdqZaD3Q0ofIZO4PO7yNs8dAF2PtvhE8Br+x
	Laz7BHKqJfIF2sgtaGfFl4QHD2Ej7cUJ+4NXWNUEAPFh
X-Received: by 2002:a05:690c:f15:b0:873:5c7b:c0ec with SMTP id
 00721157ae682-8735c7bc475mr29141477b3.36.1788645146688; Sat, 05 Sep 2026
 14:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hlib Wondertan <hlibwondertan@gmail.com>
Date: Sat, 5 Sep 2026 22:52:16 +0100
X-Gm-Features: AcwNN1VfJVYF9z5ZQ3FhBztGZrU4VAI0R3gyuNsfL59o6ZZiCqQ6xX3-aegQPwg
Message-ID: <CAFdGzA7dHZxaW4Vdzp6HcwhJxpWB+vakM85gCCk-qgAY=cHukg@mail.gmail.com>
Subject: Request stable backport of commit 4b6ec94fdae2 to Linux 6.18.y
To: stable@vger.kernel.org
Cc: mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"

Hello stable team,

Please backport upstream commit
4b6ec94fdae2407d9b8e69e3ec5f879e72ad667e, "drm/amd: Drop calls to
restore power limit and clock from smu_resume()", to Linux 6.18.y.
Mainline commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b6ec94fdae2407d9b8e69e3ec5f879e72ad667e

The duplicate restoration in smu_resume can replay a cached power
limit after AC or battery conditions have changed. On a Framework
Laptop 16 with a Radeon RX 7700S, this restored a stale 30 W limit
after reconnecting AC, although the valid firmware range was 100 to
120 W. SMU resume then failed with error 22 and left the discrete GPU
unusable until reboot. I applied the equivalent change to Linux
6.18.48 and tested repeated runtime suspend and resume cycles, AC and
battery transitions, and hibernation restores. The power limit
rejection, SMU resume failure, and GPU wedge have not recurred.

Bug report: https://gitlab.freedesktop.org/drm/amd/-/work_items/5634

Please apply this fix to Linux 6.18.y.

Thanks,
Hlib
