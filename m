Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325885;
	b=zGpQJclRhlQQOnMT6vKiDu7/kPg4Yey4CIn+UWvFXA+E2EP0dJxha5Wky1CIdhBIIQtt
	 QOQKlKfCYZ/DBVuCKE/KAMr09aYxdbChFI2B6L/hQRz/F5diSY3LGLcsZhtRyfBAw8eoc
	 GE4fp83i/Y8GuvwlOjB5kz9J8xiWctVlojQujR4TXLhp4R/hnCZvzMeHBy46bMbQaBXt+
	 Nv1KpK107jwkxd1WLi/tFH9C8D9traUznRWA85IEXdryKH/7fUtFVavGmecxJ+iMZtxS5
	 p7WMEfaQbqT6bZEIZKGfRiSiVIVRkL4j3Z5s0EQsu5/Cy/kxLVNRuZUe4SgPOPufImA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325885;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S+yaxY1IOkbr2hblsylEbiBouEaLkWRredpFXFNGEPs=;
	b=rG/GSGsSRFvgIeAoscgyBgpwUOprL6FuZc4rEovOOEKaDOedd1PzBSoTYO1XbaWkHFpK
	 DvDQrCrZFicmnYMspZUk4j1P8/zF47YvIaTLDxOI4FOFeKjCgGUJ/L7XYtTYe9Gt2tjea
	 XXoHxQgJt8EXOXOmCKBI7UVhwLo9AkQxLy1F5F3FoZ+H7m5gIVdicHwerMyF/QxY2RggM
	 ZIEY/NUBisw84hJvETP3ZamHQ1SlA5MQWy0STYPG7zRNhHamlbQVuKaRQjpTKBcppINMY
	 2tGZqfnHV1wfGh70+SA2Xxg3/DU9c3EuHC9ONz36r0wwZRALemVudfbYYmb7DK7Yr8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rld116DC;
	arc=none smtp.remote-ip=91.218.175.115
Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A56B606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A56B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rld116DC
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ekUbTVzeA1JNlzfG7xd+5633WBpvGDfH+mmSDR5DYLM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794325882; v=1; x=1794930682;
 b=rld116DCyefpF4HY6HzebCbZOPxDgtBgxSsjhBvC1bllJIxpyyrQhJq+P+PzvTn4OLH4t74n
 Mc9IMqMWy0YdoXmgUVTTIjmZC8DOoFaUD6ZduG7QNFZskXgOx/QcJ0nYRCt6F/hu0SpO1Vr+WNN
 IOz/Hc+sRP6qee1SHukxIaG4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef20ab98b7ec7150;
	Tue, 10 Nov 2026 15:51:22 +0000
X-Mizu-Trace-ID: ef20ab98b7ec7150
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 15:51:18 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: mic@digikod.net
CC: brads@mainlining.org, brauner@kernel.org, dhowells@redhat.com,
 jarkko@kernel.org, jmorris@namei.org, josef@toxicpanda.com,
 keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 morgan@kernel.org, paul@paul-moore.com, serge@hallyn.com, sergeh@kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_userns=3A_Let_LSMs_deny_the_?=
 =?US-ASCII?Q?CAP=5FSETFCAP_snapshot_for_mapping_uid_0?=
In-Reply-To: <20261110144205.2404088-1-mic@digikod.net>
Message-ID: <80A558D7-7DC3-4780-91F5-990E4917E8A4@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 10 November 2026 14:42:04 GMT, "Mickaël Salaün" <mic@digikod.net> wrote:
>Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
>records in parent_could_setfcap whether the creator of a user namespace
>had CAP_SETFCAP, because a creator writing its own uid_map only has
>capabilities in the new namespace.  The snapshot uses cap_raised(), so a
>task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
>namespace it creates.
>
>Use security_capable() against the parent namespace instead: the
>creator's credentials still belong to it at this point, so commoncap
>returns the same result, and only LSM denials are added.
>
>Do not audit this check: creating a user namespace does not use
>CAP_SETFCAP, and most namespaces never map uid 0.  The uid_map write
>that later fails has no LSM audit record.
>
>Checking CAP_SETFCAP when the map is written would not work: the
>writer's credentials then belong to the new namespace, where commoncap
>grants the creator all capabilities.
>
>Cc: Christian Brauner <brauner@kernel.org>
>Cc: Josef Bacik <josef@toxicpanda.com>
>Cc: Paul Moore <paul@paul-moore.com>
>Cc: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>

I'm logging out of mainlining.org (sigh) anything meant to be cc'ing me,
e.g: get maintainers should cc the linux.dev email instead, annoying brr.

>Cc: stable@vger.kernel.org
>Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
>Signed-off-by: Mickaël Salaün <mic@digikod.net>
>---
>
>This is independent from Josef Bacik's series, which reworks this code
>to close other ways around the CAP_SETFCAP rule:
>https://patch.msgid.link/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com
>
>That series still computes the creator's CAP_SETFCAP with cap_capable()
>and cap_raised() in cap_setfcap_level(), so it would need the same
>change.
>---
> include/linux/user_namespace.h | 5 +++--
> kernel/user_namespace.c        | 8 +++++++-
> 2 files changed, 10 insertions(+), 3 deletions(-)
>
>diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
>index 91232053775d..370961fde45f 100644
>--- a/include/linux/user_namespace.h
>+++ b/include/linux/user_namespace.h
>@@ -86,8 +86,9 @@ struct user_namespace {
> 	kgid_t			group;
> 	struct ns_common	ns;
> 	unsigned long		flags;
>-	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
>-	 * in its effective capability set at the child ns creation time. */
>+	/* parent_could_setfcap: true if the creator of this ns could use
>+	 * CAP_SETFCAP in the parent ns at the child ns creation time.
>+	 */
> 	bool			parent_could_setfcap;
> 
> #ifdef CONFIG_KEYS
>diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>index cd748e1cbace..57b7f10be74e 100644
>--- a/kernel/user_namespace.c
>+++ b/kernel/user_namespace.c
>@@ -128,7 +128,13 @@ int create_user_ns(struct cred *new)
> 	if (!ns)
> 		goto fail_dec;
> 
>-	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
>+	/*
>+	 * verify_root_map() relies on this once the creator only has
>+	 * capabilities in the new namespace.  Let LSMs deny it, but do not
>+	 * audit: the creator may never map uid 0.
>+	 */
>+	ns->parent_could_setfcap =
>+		!security_capable(new, parent_ns, CAP_SETFCAP, CAP_OPT_NOAUDIT);
> 
> 	ret = ns_common_init(ns);
> 	if (ret)
>

--- Thanks!
