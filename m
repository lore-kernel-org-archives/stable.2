Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098B40BCD0
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541103; cv=none; b=ikpn1gvqbJg7eP2/iZkQeYOp0EqakAOn/RhqTSwXqalFFPTLYsuubgdBCThjPwPOcUsK9cNy40P/Fx6wMTJDzkAfeRcz/SYA0hz89qMy9x3AhwgkHw1+BmNbNjwdB9XWc3MjE14/TwH/uj3ar8NSgex80+hlrIaNlLZ/ELwMgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541103; c=relaxed/simple;
	bh=jt9BwPd/Say6EdwIInoy7YFZeYJbexDx3c2O+7WSyFY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a7TEZFS9qM7DkGomqALOHlSWoZ8hlusYCqmTAo3wwSZEpYrgqq8pVI5Yftg356B8EhBHfygtLS0AVIpmjoHHXPmVQP9SQLc8ILnt/nSPeDcUJOEf28dQVfy+N9NNzePfgpr9bqomiFxJLpKDuZ6GxQBN1W5QExoP2OQVlU3JywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uj96ofAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uj96ofAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1EC1F00A3A;
	Mon, 15 Jun 2026 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781541101;
	bh=ResQKMVHr64SBJOXiGRUFLBBuA9hDVLH0l0qWunMCJE=;
	h=Subject:To:Cc:From:Date;
	b=Uj96ofARLMyZgijZEIFLo/Zn3GsLFRtX5qUsrZpA4Dvj5V9kPbSZF5mlTDZx/SomP
	 AqVk/8yZl/+He+09vO5C+jEgoJ2Zhe624++XhhpEFRDAFonajZq2dcNy1z8GKzyBZ+
	 SrfyzgkyGsd5JJlRx/PWvOxQfOEfbM7zF6qzfQ0w=
Subject: FAILED: patch "[PATCH] drm/amd/display: Use krealloc_array() in dal_vector_reserve()" failed to apply to 5.10-stable tree
To: harry.wentland@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,ray.wu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 18:13:31 +0200
Message-ID: <2026061531-reattach-unlatch-3025@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x da48bc4461b8a5ebfb9264c9b191a701d8e99009
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061531-reattach-unlatch-3025@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da48bc4461b8a5ebfb9264c9b191a701d8e99009 Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland@amd.com>
Date: Tue, 5 May 2026 11:52:15 -0400
Subject: [PATCH] drm/amd/display: Use krealloc_array() in dal_vector_reserve()

[Why & How]
dal_vector_reserve() computes the allocation size as
"capacity * vector->struct_size" using uint32_t arithmetic, which can
silently wrap to a small value on overflow. This would cause krealloc to
return a smaller buffer than expected, leading to heap overflows on
subsequent vector appends.

Replace krealloc() with krealloc_array() which performs an internal
overflow check and returns NULL on wrap, preventing the issue.

Fixes: 2004f45ef83f ("drm/amd/display: Use kernel alloc/free")
Assisted-by: Copilot:claude-opus-4.6
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 37668568641ccc4cc1dbca4923d0a16609dd5707)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/basics/vector.c b/drivers/gpu/drm/amd/display/dc/basics/vector.c
index e8736c134b8d..60bd9ead928a 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
@@ -289,8 +289,8 @@ bool dal_vector_reserve(struct vector *vector, uint32_t capacity)
 	if (capacity <= vector->capacity)
 		return true;
 
-	new_container = krealloc(vector->container,
-				 capacity * vector->struct_size, GFP_KERNEL);
+	new_container = krealloc_array(vector->container,
+				       capacity, vector->struct_size, GFP_KERNEL);
 
 	if (new_container) {
 		vector->container = new_container;

