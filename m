Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631F41F942;
	Wed, 19 Aug 2026 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787180998; cv=none; b=FLf4UmwYWaWRNIFRWzRoreGtvotifWlO/y04rpyaM3jQkh8++sto9UHSwd5L8yJUvYu83dB0pJYcMVjbWbC7N+t3smVVfd1SQTR/uDYexIHElebpxGUv4lslRoTwSu1tNJ7i16mgSz3bRdn9wR3ANHiiKPfuvVr2HGjD1U7JETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787180998; c=relaxed/simple;
	bh=/FEG26D+sa/7sriN55UB6u03YL4u4CWR85ubKYD7zIk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=szG9KIuFVbJlpJzQKIV1l4T6l6fejj78C933+uroLVBqysY+XqUMnajIKAGIM5kdXhrNffpWBiau3Tm2pmTMX1PNCd/r4W9zXa+Y8BZMBZLAOF58EVg8iIxwBLHveei37KXBV2Hs2imcV04J+Zw+P3KJP3NMn7mF/ywevVGn1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNnanCph; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNnanCph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356491F000E9;
	Wed, 19 Aug 2026 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787180997;
	bh=92sAIl034UVvrjZzhGbIXHo8EB/Zw9a0LG/wt2JppBc=;
	h=From:Subject:Date:To:Cc;
	b=UNnanCphHmtaW87zNtZsjZwFU8YPz6DPmMXoMfNkJmqefcPkklsscYXWBbaJwmTdA
	 1Z4ybYz2uCQK/1fyICi/suG8Wu65HbcrlqqNqx+IRb4GkzHqC8bmO2cmtBAC+sZjLH
	 L3KZfLuSPN3Lldt4rEQC8QN0DEehi6VsZv/+lanVMVAoLVKGJjn52gNvAoNJhkD45o
	 +KmNbPF58TAuL85ZNqFt1v0ba47yRCIngIa7vV3DlxxT8pttVau2KOfFTLas2i9CYf
	 xqoeAPWx3itc9oVCEKZRP7DqPkmw1LAUffUeh4MbOwB4Eun/dFh4xKmBHUBwtpchSJ
	 Y3yFNRcPXyhEQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/22] coredump: allow to create sparse coredumps on the
 coredump socket
Date: Thu, 20 Aug 2026 01:09:17 +0200
Message-Id: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOTQ6CMBCFr2K6toQWpcSV9zAs+jNCRVoyhaoh3
 N0WD+Dym3nvy1tJALQQyOWwEoRog/UuAT8eiO6l64Bak5jwktdlwxh9eRyo9ghmGScaJokBKGu
 YEEYIVbITSdUJ4W7fu/bW/jgs6gF6zq6cUDLVFEqn+3waZZgBiygKnr+9DbPHz74qsmz5MyAyW
 lJtKmgUg+pcm+sA6OBZeOxIu23bF3rg5DzpAAAA
X-Change-ID: 20260811-work-coredump-sparse-18177d77b014
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4846; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/FEG26D+sa/7sriN55UB6u03YL4u4CWR85ubKYD7zIk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me9jEyk5ridXtlf7sdyUsk0Vh8zOBQpZf5je1Smha
 lFjqPazo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIaCgx/Je7qLMi4uN9p6pnC
 21/2lK9fY7bMhIlhz12ZCa+P/r7/Ipzhf9n3Tn7B1qd3XGJj+lcn7n30o2ZRdHTxgoeChrvWP7v
 vwQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A coredump generated via the coredump socket ends up transferring
zeroed data when a mapping contains holes. For a large process that
maps a bunch of data that's wasting a ton of work.

Jacob ran into this and Josef has bitched^wcomplained about this to me
before. I dislike the coredump_filter bit solution in [1] which stops
each PT_LOAD at the last populated page.

The problem is real though. I don't think coredump_filter is where we
need to solve this. That mask says which kinds of memory to include and
it propagates across fork and exec, whereas what is being selected here
is an encoding mechanism.

I also think that the usermodehelper - may it swiftly die - isn't really
salvagable for this and it's not the future anyway. The coredump socket
already has a handshake for stuff like this.

I always had an idea how this would look like but punted on it back
then. So here it is.

A server that raises COREDUMP_RECORDS in coredump_ack->mask doesn't get
the coredump as a plain byte stream but as a sequence of records. Each
one a struct coredump_record_header followed by what it describes. A
data record carries its bytes. If a server also raises COREDUMP_SPARSE,
zero records are sent for unpopulated mappings. They only indicate how
many zero bytes need to be written and do not include data. Reassembling
the records gives back the same coredump. A debugger and everything else
still see an ordinary core file and nothing outside the coredump server
has to learn anything.

Numbers from the selftests, on a kernel built from this series:

- a process with 128 threads: 1424153 bytes on the socket for a
  coredump of 1075150848 bytes
- a 256MB mapping with the first and last page touched: 188793 bytes on
  the socket for a coredump of 268890112 bytes
- the same 256MB mapping with COREDUMP_RECORDS alone: 271009312 bytes on
  the socket, so the record overhead itself is under one percent

The first one is the interesting case. Almost all of it is thread stacks.
All stacks are 8MB reservations that are nearly all holes. And they are
holes in the middle of the dump rather than at the end.

Link: https://lore.kernel.org/all/20260731171336.2255844-1-jalalonde@meta.com [1]

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Use standard naming aligning with other subsystems.
- Add a termination record to make this really clean.
- Link to v1: https://patch.msgid.link/20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org

---
Christian Brauner (22):
      powerpc/spufs: don't dump more than the note supports
      coredump: refuse negative skips
      coredump: set the minimum send buffer size
      selftests/coredump: discard the right amount after the coredump request
      selftests/coredump: collapse the expected request check into the helper
      selftests/coredump: add a separate helper header
      coredump: pin the protocol struct sizes
      coredump: move the negotiated mask into struct coredump_params
      coredump: deduplicate the to_skip flush
      coredump: make the dump helper return bool
      coredump: always chunk writes
      coredump: clean up coredump state handling
      coredump: add COREDUMP_RECORDS to the coredump socket protocol
      coredump: add COREDUMP_SPARSE to the coredump socket protocol
      tools: sync coredump.h header
      coredump: send the coredump in records if requested
      coredump: describe the holes when COREDUMP_SPARSE is negotiated
      selftests/coredump: test COREDUMP_RECORDS and COREDUMP_SPARSE
      selftests/coredump: hand the record stream to a sink
      selftests/coredump: put a hole in the middle of a sparse mapping
      selftests/coredump: simulate a blob store
      selftests/coredump: show how to inspect the task to decide how the coredump should be sent

 arch/powerpc/platforms/cell/spufs/file.c           |   18 +-
 fs/binfmt_elf.c                                    |   12 +-
 fs/binfmt_elf_fdpic.c                              |   12 +-
 fs/coredump.c                                      |  325 ++++--
 include/linux/binfmts.h                            |    3 +-
 include/linux/coredump.h                           |   33 +-
 include/uapi/linux/coredump.h                      |   79 +-
 tools/include/uapi/linux/coredump.h                |   79 +-
 .../coredump/coredump_socket_protocol_test.c       |  783 ++++++++++++-
 tools/testing/selftests/coredump/coredump_test.h   |   31 +-
 .../selftests/coredump/coredump_test_helpers.c     | 1171 +++++++++++++++++++-
 .../selftests/coredump/coredump_test_helpers.h     |   53 +
 12 files changed, 2399 insertions(+), 200 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260811-work-coredump-sparse-18177d77b014

