Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0A21DF736
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787971837; cv=none; b=P8ZAi3AOQJvkMTtTGdmRaFTnBYlEtCn7r6gW1DZWZ0H2g1ugO10h6Wi6jFsS/9vC8VrInUumlNPVLqHPSKrAPbmwBljvDMlDXSMi3i7dwr0vpUAOYfemJN4HPshe6ZQSqxO4Y1b2RHpUZFCZVJIIxG0IRca9uozR3Szp+BKsn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787971837; c=relaxed/simple;
	bh=lCZXxzRerXIchs3t7cBfPwyZnkO4/85G4yhAubjTB/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TgPk1KG8AIcz8lWSgcZkjZDXwVhHfWeA4kIWiGlrEtkNzGCQqdK5rGwzcGf0L3cq1va2f5hpMxwCck0AbQFI/FzBMoLiMaUAdcxp91mI44uLiV+za39mZ5sQuhDByxhqP0DjYIOj2COz0Ff3uA/bIIBljLTfXf85Fx4mqG/Raho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0ZHTeUK; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0ZHTeUK"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso1929862a12.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 19:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787971835; x=1788576635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vFZPhakOwxRZAFtn7md9lSxeY1Cg1zyr2h0Gca9vEbU=;
        b=a0ZHTeUK8witb+tda1eYJ+paPdPNF+KSWEbjlSb6Y8TdD2pSjwcFpviG2n7GoqggWm
         rcRo6nkuh8NLRFzkNY2aWC0tTY9krs2qtAq3nvnDlWWkMMBwYVuwZeB+G+qBahnsuSOc
         /3YkCzS1lYwkyKoMNvd7ieNg1NWYSI2Ef/18cG0Ru4NlC3MCoTNndZXWdq+YT2LkmzZc
         PojQcW0g9tIKmu0UKWiXOJpwCWts+tLZyj2oGRaQf/uEHJR0DUWFNtQX6qfpPOt6HuME
         xQwIINdNx/jE3Bp1soLBfhGBLjPt42oPsXxEj+fMYjcgt/sOga9pJjI5P+xjwZzLRcAC
         /vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787971835; x=1788576635;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFZPhakOwxRZAFtn7md9lSxeY1Cg1zyr2h0Gca9vEbU=;
        b=nXKCiWVhlNJ2rG3ll1wL4Bu+RwI3GIy0XpuDq8AgzAO88Fx3UDeVbvN6PynxPkcgIo
         0XTrQWbgd1jKSXXETVtSuA5iA/uhrcWj6Ok1ZRLcZ6BJgK51PtjRpl9pmVwuPaD1zh/x
         0JLfv2HudMelAG+yQlM8eRMDEwNF+u4vTLgYmy5b7+OymK4KisFvpNwLDcU1gJ6lTMxz
         h8eI+E8mGD/wnoRbkt/MKaX1loTvZ8+hjOk9YPiX0JjXtPtF9NEjygkH//+WYO+xiDjZ
         ynWpIc+xd9QwLu+uC0ml2e0fEI0G/tk5vrnN0VF4KR6P8enlTrgDeC6CWyG4Ey2fLgx2
         mv4g==
X-Forwarded-Encrypted: i=1; AHgh+Rrk5eU4yj39YcGwlxSm7PaPxuUiESOSFM+s9DUtkC1lchyfNOIryP+8qBNbSeA5ubO0FTB/ssk=@vger.kernel.org
X-Gm-Message-State: AFuF++nH5nz8Lj2aHSAYuzXiICnoorexGL+4IuI/AMQ/DNleFhe3iq10
	EW7z0TCuc9QwQdZwCXEuq1rIqtECDskd7DJEntMI6OTcqQyHrJLQa8P7bE8tPbl/l9fvCProQMZ
	bVz9Ko+fpA/yi1RdbIKQ1cg==
X-Received: from pgby8-n2.prod.google.com ([2002:a05:6a02:6508:20b0:cc1:c78b:a2fb])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:f94:b0:857:7317:cff4 with SMTP id d2e1a72fcca58-8577317d1bcmr6303601b3a.21.1787971835104;
 Fri, 28 Aug 2026 19:50:35 -0700 (PDT)
Date: Sat, 29 Aug 2026 02:50:33 +0000
In-Reply-To: <20260828183801.04fd2d2a6af837cb45b60e0f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828183801.04fd2d2a6af837cb45b60e0f@linux-foundation.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260829025034.2500920-1-jthoughton@google.com>
Subject: Re: [PATCH v2] mm/khugepaged: Don't install PMDs in
 uffd-minor-registered VMAs
From: James Houghton <jthoughton@google.com>
To: akpm@linux-foundation.org
Cc: baohua@kernel.org, baolin.wang@linux.alibaba.com, david@kernel.org, 
	dev.jain@arm.com, hughd@google.com, jthoughton@google.com, kas@kernel.org, 
	lance.yang@linux.dev, liam@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, shy828301@gmail.com, stable@vger.kernel.org, 
	usama.arif@linux.dev, ziy@nvidia.com, zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:38=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 28 Aug 2026 18:18:11 -0700 James Houghton <jthoughton@google.com>=
 wrote:
> > Ah, just to be clear, I linked a repro on v1. Here[1] is that repro.
> > Sorry, slipped my mind to also include it in the notes for this v2.
> >
> > [1] https://gist.github.com/48ca/d399bf534158e80241fb4937ef1ff664
>
> Cool thanks, I'll slap this into the changelog.
>
> # ./a.out
> TAP version 13
> 1..1
> madvise(MADV_COLLAPSE) succeeded
> ioctl(UFFDIO_CONTINUE) failed: File exists (errno=3D17)
> not ok 1 - memfd userfaultfd MINOR continue test
>
>
> We do have a ton of uffd selftesting code in there.  Adding this case
> to uffd-unit-tests.c would presumably be pretty simple.  We don't
> really have a policy on adding a test-case after fixing something -
> it's common practice but why?  We already fixed it!

Good idea. The below patch should work; I'll send it properly on Monday.

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/s=
elftests/mm/uffd-unit-tests.c
index ef9b3956bdcf..227bcd6aef9d 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -518,19 +518,34 @@ static void uffd_wp_fork_pin_with_event_test(uffd_glo=
bal_test_opts_t *gopts, uff
 	uffd_wp_fork_pin_test_common(gopts, args, true);
 }
=20
-static void check_memory_contents(uffd_global_test_opts_t *gopts, char *p)
+static int __check_memory_contents(unsigned long offset,
+				   unsigned long nr_pages,
+				   uffd_global_test_opts_t *gopts,
+				   char *p)
 {
 	unsigned long i, j;
 	uint8_t expected_byte;
=20
-	for (i =3D 0; i < gopts->nr_pages; ++i) {
+	if (nr_pages + offset < nr_pages)
+		err("overflow in memory check");
+	if (nr_pages + offset > gopts->nr_pages)
+		err("out of bounds memory check");
+
+	for (i =3D offset; i < nr_pages; ++i) {
 		expected_byte =3D ~((uint8_t)(i % ((uint8_t)-1)));
 		for (j =3D 0; j < gopts->page_size; j++) {
 			uint8_t v =3D *(uint8_t *)(p + (i * gopts->page_size) + j);
 			if (v !=3D expected_byte)
-				err("unexpected page contents");
+				return 1;
 		}
 	}
+
+	return 0;
+}
+
+static int check_memory_contents(uffd_global_test_opts_t *gopts, char *p)
+{
+	return __check_memory_contents(0, gopts->nr_pages, gopts, p);
 }
=20
 static void uffd_minor_test_common(uffd_global_test_opts_t *gopts, bool te=
st_collapse, bool test_wp)
@@ -539,6 +554,8 @@ static void uffd_minor_test_common(uffd_global_test_opt=
s_t *gopts, bool test_col
 	pthread_t uffd_mon;
 	char c =3D '\0';
 	struct uffd_args args =3D { 0 };
+	unsigned long checked =3D 0;
+	bool bad_contents;
 	args.gopts =3D gopts;
=20
 	/*
@@ -564,19 +581,51 @@ static void uffd_minor_test_common(uffd_global_test_o=
pts_t *gopts, bool test_col
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
=20
+	if (test_collapse) {
+		/*
+		 * Read just a single page and try collapsing. The collapse
+		 * should either be rejected or be a no-op.
+		 */
+		if (__check_memory_contents(0, 1, gopts, gopts->area_dst_alias))
+			err("unexpected memory contents before collapse");
+
+		madvise(gopts->area_dst_alias, gopts->nr_pages * gopts->page_size,
+			MADV_COLLAPSE);
+		/*
+		 * If the above collapse mapped pages that were not explicitly
+		 * CONTINUE'd, the below __check_memory_contents() will not
+		 * fault on some pages, resulting in incorrect contents. The
+		 * PTE for the first page may get retracted, so avoid checking
+		 * that page, as we might take a second fault, flipping the
+		 * contents a second time.
+		 */
+		checked =3D 1;
+	}
+
 	/*
 	 * Read each of the pages back using the UFFD-registered mapping. We
 	 * expect that the first time we touch a page, it will result in a minor
 	 * fault. uffd_poll_thread will resolve the fault by bit-flipping the
 	 * page's contents, and then issuing a CONTINUE ioctl.
 	 */
-	check_memory_contents(gopts, gopts->area_dst_alias);
+	bad_contents =3D !!__check_memory_contents(checked, gopts->nr_pages - che=
cked,
+						    gopts, gopts->area_dst_alias);
=20
 	if (write(gopts->pipefd[1], &c, sizeof(c)) !=3D sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		err("join() failed");
=20
+	if (bad_contents && test_collapse) {
+		uffd_test_fail("unexpected memory contents after collapse");
+		return;
+	}
+
+	if (bad_contents) {
+		uffd_test_fail("unexpected memory contents");
+		return;
+	}
+
 	if (test_collapse) {
 		if (madvise(gopts->area_dst_alias, gopts->nr_pages * gopts->page_size,
 			    MADV_COLLAPSE)) {
@@ -593,7 +642,10 @@ static void uffd_minor_test_common(uffd_global_test_op=
ts_t *gopts, bool test_col
 		 * This won't cause uffd-fault - it purely just makes sure there
 		 * was no corruption.
 		 */
-		check_memory_contents(gopts, gopts->area_dst_alias);
+		if (check_memory_contents(gopts, gopts->area_dst_alias)) {
+			uffd_test_fail("unexpected memory contents");
+			return;
+		}
 	}
=20
 	if (args.missing_faults !=3D 0 || args.minor_faults !=3D gopts->nr_pages)
