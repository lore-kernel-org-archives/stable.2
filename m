Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082211;
	b=NiN1ycbNJbmAsarpZ+Z01v6AtkwxTIL2SQSHL8PNMYJWVlvg1zYfKOBA9c+LF96RkfhJ
	 mfUmvrEcrsHUrYbsiXjxTrJeQ5N9p0swLRXQoEJgpJ8NYDrayfbVN1YHZtjvz7S0+rgal
	 sIhnH0DWe2coCC3xrwid3aKZjeLHicRnlUOHi2jZYm62lpI9IQ+oJMZkKcEJjLGdIEWYC
	 w6ZLVZoUcOqpneTzAX0KdnaH4FJybWU3+ZRWqpd57vhVbooLQqQNMR29BpsMeAsf5eoN1
	 zNc3Q/HXm8nd2TDeOl6L377KR5CPRsWVIuVWbUkQXyLo4trKoXewLJ+b1N82Jh0+AgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082211;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oUgpNIq5y7P8hrOoDRzoRBlVsghumVDo96fytymZU4o=;
	b=akhSK4jYcAFwUnNdZCwmcZ8V4epug4UB2ZLFxM2Tk+mULlp2mY0bO39ej9lsg602LXug
	 5+kGrzstlj/khhefnS0SFmtSgwhO/D7otuLnBwKfjHC/pE0U33zwuqZ1AxDc5cl3Dn7Xr
	 lTLFbP67zDLVY6bT0RgI48FngRWnZh0NLP3lvZ62aMWE7gLay/aUavndGVRlHyYLtzRKJ
	 4EcIyujxJBw1Nt4rT5RG2lxt4cvL2/3vkk0Q7NrGBM42zGkcfSWyaYEK8tuoyIpiPXQAY
	 DyHaMKMwPzYosvcNiQ0bFovghpuvchbWz0f8khxDix/DMZt8/onmWqSxVmUoRK6TxOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8GiealS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6A606D820;
	Sat,  7 Nov 2026 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8GiealS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC091F008A7;
	Sat,  7 Nov 2026 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082211;
	bh=oUgpNIq5y7P8hrOoDRzoRBlVsghumVDo96fytymZU4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c8GiealSX7kI27Hkj91eti8JBokuozsH9hmLJ2W+cHpUKvghW7FhbRPdGgKqdIImM
	 5MVOfYeYluV3UkNGpqzbB90EiRcgKcT25oJrfVu7Pu+tQu6qn/vK01Fg53jesd9FCI
	 4/5h0ACmiirgOTFGbgzFUfD8Oe/TGZ6H9bnCD8BV+IibAKWyUpNQghLscLvQp1MRQE
	 8tXNithdLu9suG7QjyiOLWuDZy6+NHUUd1c/qLRJnbAvNYszj+dW0JUfdV8YwAmb9o
	 uOjd+lD+sdGF5J3wCQYXfSzn4/4v58IVs9sBUhzFm+l8AQLVgePEKHvp3HufUPsy2A
	 35BW5Dp2u7rEA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.18.y 4/5] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Sat,  7 Nov 2026 12:10:00 -0800
Message-ID: <20261107201001.206120-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107201001.206120-1-sj@kernel.org>
References: <20261107201001.206120-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota->charge_{target,addr}_from saves the target and region the
scheme's quota limit is reached.  damos_skip_charged_region() skips the
target and regions before the point.  The target that was assigned to
charge_target_from could be dynamically removed from the context by the
runtime parameters update (aka commit) feature.  In this case,
damos_skip_charged_region() cannot find if the point is passed or not,
so the scheme is effectively disabled.

Similarly, the user could also remove all the regions of the target
using the runtime parameters update feature.  It would be uncommon to do
that, but it is a supported feature.  Because the skip pointer detection
logic (damos_skip_charged_region()) works for each region of targets,
this result in the logic is entirely skipped and the scheme is
effectively disabled again.

The user impact is that the DAMOS scheme could suddenly stop working
under certain uses of the runtime parameters update feature.  It could
surprise users. No crash or leak happens though.  Users could also
simply work around by re-installing the scheme.

Catch the corner cases in damos_adjust_quota() and reset the pointers.

Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org
Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c49b8
Cc: <stable@vger.kernel.org> # 5.19.x
(cherry picked from commit 5695abc4e742b947f586bfb6a080a80ad9957e5d)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f2666770b5436..00cd0e2a1e341 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2261,6 +2261,26 @@ static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
 	trace_damos_esz(cidx, sidx, quota->esz);
 }
 
+static void damos_fix_stale_charge_pointers(struct damon_ctx *c,
+		struct damos *s)
+{
+	struct damos_quota *quota;
+	struct damon_target *t;
+
+	quota = &s->quota;
+	if (!quota->charge_target_from)
+		return;
+	damon_for_each_target(t, c) {
+		if (t == quota->charge_target_from) {
+			if (damon_nr_regions(t) > 0)
+				return;
+			break;
+		}
+	}
+	quota->charge_target_from = NULL;
+	quota->charge_addr_from = 0;
+}
+
 static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 {
 	struct damos_quota *quota = &s->quota;
@@ -2297,6 +2317,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 			damos_trace_esz(c, s, quota);
 	}
 
+	damos_fix_stale_charge_pointers(c, s);
+
 	if (!c->ops.get_scheme_score)
 		return;
 
-- 
2.47.3
