Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C83E51DE;
	Fri, 16 Oct 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166540; cv=none; b=EVOBEygyDEA/IOu1zNQ9pNTbl/X8AlYI/fPBGdvCE6LLfgO9N5z5IWa7R9s9gt1RP6iI/SAAKZkUo7MFvFQ67Bk0wLqxOGzqKrUB9Zb+g9yAYxwde77yQOqpbfLKpSXO9zhoxHEOPxBsQg9N6SbwvitY7Jl4zhO6pkZh700J5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166540; c=relaxed/simple;
	bh=sRNtULvTIFu/QdmdvWWCKAb4m/6z20vdBdBV3DFxyvY=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=GwnH2HfhwuV+7RNKcSYvI2KO2ADSrSTJsCk5DJbVcTDtVPlvyxfviCN16TyfakobVVxhJHsPkjeIqevOHIzsc9AJer4pEiQuvkwWFRsc7fjdU0JmWroMYRXgq2YT2YflK6RQ8dGVn4xCF7gPeZE+8MftGBTzLgVz50CFaYseXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Date: Fri, 16 Oct 2026 17:01:54 +0100
From: Bradley Morgan <brads@mainlining.org>
To: sashal@kernel.org
CC: broonie@kernel.org, corbet@lwn.net, error27@gmail.com, geert@linux-m68k.org,
 gregkh@linuxfoundation.org, kees@kernel.org, konstantin@linuxfoundation.org,
 ksummit@lists.linux.dev, laurent.pinchart@ideasonboard.com, leon@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux@leemhuis.info,
 mst@redhat.com, ojeda@kernel.org, rdunlap@infradead.org,
 skhan@linuxfoundation.org, stable@vger.kernel.org, tytso@mit.edu,
 workflows@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/7=5D_docs=3A_stable-kernel-rule?=
 =?US-ASCII?Q?s=3A_drop_rules_the_stable_trees_do_not_apply?=
In-Reply-To: <20261016152828.3765695-4-sashal@kernel.org>
Message-ID: <DF061D87-D1A3-42F6-AA3C-C288D3CB6BF3@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 16 October 2026 16:28:23 BST, Sasha Levin <sashal@kernel.org> wrote:
>The stable trees do not apply the 100 line limit or the exclusion of
>theoretical issues, and they require a fix to be correct and tested
>rather than obviously correct. Drop those rules.
>
>Assisted-by: LLM
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> Documentation/process/stable-kernel-rules.rst | 6 +-----
> 1 file changed, 1 insertion(+), 5 deletions(-)
>
>diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
>index edf90bbe30f43..625c1b5b0e16b 100644
>--- a/Documentation/process/stable-kernel-rules.rst
>+++ b/Documentation/process/stable-kernel-rules.rst
>@@ -7,8 +7,7 @@ Rules on what kind of patches are accepted, and which ones are not, into the
> "-stable" tree:
> 
> - It or an equivalent fix must already exist in Linux mainline (upstream).
>-- It must be obviously correct and tested.
>-- It cannot be bigger than 100 lines, with context.
>+- It must be correct and tested.

s/tested/fully tested ?

'Tested" to agents would be just a basic compile test, maybe we could
define here what you want the agent to do?

E.g: a W1? A QEMU repro? And others.

> - It must follow the
>   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
>   rules.
>@@ -24,9 +23,6 @@ Rules on what kind of patches are accepted, and which ones are not, into the
>     regression they should only be submitted by a distribution kernel
>     maintainer and include an addendum linking to a bugzilla entry if it
>     exists and additional information on the user-visible impact.
>-  - No "This could be a problem..." type of things like a "theoretical race
>-    condition", unless an explanation of how the bug can be exploited is also
>-    provided.

To help agents filter bugs see below:

>   - No "trivial" fixes without benefit for users (spelling changes, whitespace
>     cleanups, etc).

What I tend to do when I use AI on my own projects to find bugs are to get
it to "verify" what it finds to be a good enough bug. Could you refer to
the security document here? That could help very well for AI agents to
find proper bugs.


Id also suggest that perhaps you *could* make a new patch saying that 

"When finding bugs, you need to verify that this bug is severe enough to
need stable backporting or a CVE, if you reckon it is not severe enough
for them, if it's not reproducible, eliminate the bug from the results"

What do you reckon Sasha?

> 
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
