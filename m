Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730719;
	b=Pmlh8jV5ehevPK1AZcOOGni685h19rq+kSk5iacYLHRBs0rAo1jhnZiLFOF6mx9eBLv+
	 G4qNlRXii5GtHAq5cXaPWM/WE5LJn7hCA4RtX22ocZ1XyxvPqU1VOFKrIkOgwlGRsKom2
	 4xoHefo3NwqQPSCjHgVoRe1zK/ASnR5YPXuY6OKnh9D3dafKLc/1E1eqzNx97uTQqG4sk
	 BTy7HzRXK/uieXReIFpd/MDK8aqz5L3IuyyQQ6kBrys2UhORNISSG5xwkVtd70q4y1/Uo
	 NY/mFd1lr84SNAk23acONHS6vKOnboqwERBLvuJws7odP/uAJcvYTsK4tKWmnWpz6vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730719;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YL7pUVyNm44/Ihd2CJn9w6SXbjo2vEV8c+XqARMDpew=;
	b=y2fakBrzrqNTxqAxDCwSRlWapvpfAopttlR6i2U7mrX5QgYULfrlMzoR6bs21RFvLVL0
	 s8ABe8Tf1JFYbyoRx1I2Xsyljw9IWyI1Op5EwGfQYluqJ5OBhtZ0BU1WliOn2sgGxoWeN
	 8WNTlc/7blkJ46Yurc+jiHcKoAxLXXAPBMWBBkooUlCs1Rtw62BftZAi2+rfYX7jxE69P
	 ED+FEfHdJoSDlTAQSYNsQPnp7zdz7ajLL/am4GRrl3nkWBM/B/fnCwTXOrnWhMygiJh7P
	 K5TVdao0CqchGmlgaRflp5HYc5pSzzePojsJf9NPGGIoIaRKBLy91nJzXURPrceItGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4aik7Uv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5B606A326;
	Tue,  3 Nov 2026 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4aik7Uv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA3A1F000C1;
	Tue,  3 Nov 2026 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730718;
	bh=YL7pUVyNm44/Ihd2CJn9w6SXbjo2vEV8c+XqARMDpew=;
	h=From:Subject:Date:To:Cc;
	b=A4aik7UvTF+WBnIEzANiOSGgFaXLqjJm80sWxnLlbMh4FnIt0x8C5uRcgdMKlvJKS
	 +3D7SA68QXXmbdnQaybnbvcwtnvQ6BcikEn1lAWCt09If373L+S9PQ2j2CQfnzcLBj
	 3TxbEz81yFpdP+/UQA/mV+0sIGjX59VF4A71jqjZ80YpmimmDR+JzxiYxlhhQtBinP
	 DDyhfldjwHvV4Vu2cHjzNbl4Ej+UVYy5cL5ZS6SnV1RxtorKYeF8YdVGpULGZGQJLR
	 SLgrMbLoZKZLBvL9Wx8bqpbZ8GrvpUYxSvk7m85OmBC/j93QJ1U58pQv7Kz574M4+w
	 4xQtd7t8JUjaQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/2] mm/memfd: handle GUP references reliably when
 write-sealing
Date: Tue, 03 Nov 2026 19:31:43 +0100
Message-Id: <20261103-fixes_core_2-v1-0-f332954f1df4@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI8o6moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMj3bTMitTi+OT8otR4I11jy1RTy8S0lERLQ0sloJaColSwPFBHdCy
 EX1yalJWaXAIyQ6m2FgAYc4tScAAAAA==
X-Change-ID: 20261102-fixes_core_2-39e59afda919
To: Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Rheinsberg <david@readahead.eu>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=david@kernel.org;
 h=from:subject:message-id; bh=7nmu6fRF1UbgSM50uuDb6xwGPEFwgJ+ETyCbNbuUspQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJeaUzXmx9/Xi7wYJ3EfcPQuq+aeyNMehVU1wQ9/ezl4
 OJpfTuwo5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgImcDmD4n/DbZVlKGAOfCcdW
 z/fTtX+v0ayb//LJfp1ovtSTEz9st2NkeMW5bKX8AS2Ps6ubhFk6jXu7SpUvzNcR1Dz+6fJ00/p
 +dgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

I spent way too much time on this, looking for better options. I think
patch #1 fixes the most immediate issues but something like patch #2 is
needed.

Long story short: someone can trigger a race such that we don't detect
GUP references when write-sealing, allowing to modify content later.

Patch #1 handles pins reliably for folios with a pincount. Patch #2
handles the remaining references, but can reject write-sealing with
populated file mappings. vm.memfd_write_seal_mapped allows restoring the
legacy behavior if needed.

All alternatives to patch #2 I tried ended up too complicated and nasty
in corner cases. We should never have allowed write-sealing with
existing file mappings.

Plenty of details in patch #2.

Did some testing on x86-64 without any surprises.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (2):
      mm/memfd: handle GUP pins more reliably when write-sealing
      mm/memfd: handle GUP references reliably when write-sealing

 Documentation/admin-guide/sysctl/vm.rst | 21 +++++++++++++++
 mm/memfd.c                              | 45 ++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)

---

base-commit: 462595652740dc45f2392dc59d9609e509ee60af

change-id: 20261102-fixes_core_2-39e59afda919

--

Cheers,

David

