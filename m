Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3848E0D3
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817089; cv=none; b=bMXQJb7nB8K8rX+tEdvSl8hvJDWhTK9bl4Bhs5iDdTmFzPloi8fulCShkLX/oqjyD8EOSRqMq5jJxlFv8TOvkjeee4ZeAdkZs3qrtm2ZA57fY+gr2FTYzfL42HFHv3rs1xrVWB6dAFFisX6oTriwp8isOuRzE8YsN4an44TVUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817089; c=relaxed/simple;
	bh=M5tjlpDbr8QR/FQIMpXFHK2RdjZRUoAw3crDb7kb8ic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eI+oosV0qnaswRi1vt4jDBdNeToRrXZff9wzJjyTOmbS9H2ZGjL5Xq3eb/t4Qj7GNxT0163I5LU+AY+qa8V81+ZRkE9dJbhpfVKv6+mER+60ZpnglnQKjxBYGhT1/NYXaqmX/BLIy/Vt7VdJoCtGTvZU2sajLERkRdq6L3QDufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bWX96ANE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bWX96ANE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2A91F0089B;
	Mon, 12 Oct 2026 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817088;
	bh=+VOFiSjmiqDtGJMo8YCfRKAOVEWTZyX/trGeRn6SA00=;
	h=Subject:To:Cc:From:Date;
	b=bWX96ANEUX7l71WLacw5XAV+UmvqMsraOU5COykweYS5rBe30YlrNgPRaez0qNm4U
	 ajDe1ezBuCb0iFA83azTkueww8mzLm0Dx7RDawEcIQWMHoqmrIkaXW+1LreR7dsD1I
	 Jaz9FOYD5v6EcnAq5JQx1wODL7JCbv6UvVBkjKvA=
Subject: FAILED: patch "[PATCH] regulator: of: fill in supply names in" failed to apply to 6.18-stable tree
To: alchark@flipper.net,broonie@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:58:13 +0200
Message-ID: <2026101213-dealmaker-endearing-04b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e2151c29cec73f6cc70abf1c7cbc7b9b202489f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101213-dealmaker-endearing-04b6@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2151c29cec73f6cc70abf1c7cbc7b9b202489f5 Mon Sep 17 00:00:00 2001
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 30 Sep 2026 20:13:03 +0400
Subject: [PATCH] regulator: of: fill in supply names in
 of_regulator_bulk_get_all()

of_regulator_bulk_get_all() returns an array it allocated itself, and
fills in only the consumer of each entry. Every other way of getting a
bulk array has the supply name set, because the caller provides it, and
the core expects it to be there: regulator_bulk_enable() prints it when
a supply fails to enable, so a caller that hands such an array to it
dereferences uninitialised memory on that path.

Copy each name into the array's own allocation, right behind the
entries, so that it shares the array's lifetime and callers still have
nothing extra to free. That also retires the fixed 64 byte stack buffer
the names were assembled in, which is_supply_name() never bounded the
copy against.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260928-b4-rk3576-reboot-mode-v1-0-65486b03bd41@flipper.net?part=3
Fixes: 27b9ecc7a9ba ("regulator: Add of_regulator_bulk_get_all")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
Link: https://patch.msgid.link/20260930-regulator-get-all-v2-1-ca82070d22f2@flipper.net
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c0cc6cc0afd8..785b7a11dfc6 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -935,15 +935,15 @@ static int is_supply_name(const char *name)
 int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 			      struct regulator_bulk_data **consumers)
 {
-	int num_consumers = 0;
+	int num_consumers = 0, names_len = 0;
 	struct regulator *tmp;
 	struct regulator_bulk_data *_consumers = NULL;
 	struct property *prop;
+	char *names;
 	int i, n = 0, ret;
-	char name[64];
 
 	/*
-	 * first pass: get numbers of xxx-supply
+	 * first pass: get numbers of xxx-supply and the room their names take
 	 * second pass: fill consumers
 	 */
 restart:
@@ -953,16 +953,19 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 			continue;
 		if (!_consumers) {
 			num_consumers++;
+			names_len += i + 1;
 			continue;
 		} else {
-			memcpy(name, prop->name, i);
-			name[i] = '\0';
-			tmp = regulator_get(dev, name);
+			memcpy(names, prop->name, i);
+			names[i] = '\0';
+			tmp = regulator_get(dev, names);
 			if (IS_ERR(tmp)) {
 				ret = PTR_ERR(tmp);
 				goto error;
 			}
+			_consumers[n].supply = names;
 			_consumers[n].consumer = tmp;
+			names += i + 1;
 			n++;
 			continue;
 		}
@@ -973,9 +976,16 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 	}
 	if (num_consumers == 0)
 		return 0;
-	_consumers = kmalloc_objs(struct regulator_bulk_data, num_consumers);
+	/*
+	 * The supply names are kept in the same allocation as the array, so
+	 * that they share its lifetime and the caller has nothing extra to
+	 * free.
+	 */
+	_consumers = kzalloc(size_add(size_mul(num_consumers, sizeof(*_consumers)),
+				      names_len), GFP_KERNEL);
 	if (!_consumers)
 		return -ENOMEM;
+	names = (char *)(_consumers + num_consumers);
 	goto restart;
 
 error:

