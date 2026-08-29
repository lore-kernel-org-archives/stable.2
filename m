Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA72C0303;
	Sat, 29 Aug 2026 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788022191; cv=none; b=L4UcP4plgIm6+lSXos+b3TIZ5IKGC5YGeQn81Vv3bSKC4GD//D/+Hc4zRwtGaZKOTx7jbuDYz1Lz6w3AvfzYl3fQhqVv4bdP+yWnfQGLXEgRPXTZueE+oAzeghbTbNkwth+XLjBpopyXgq0raMHTH6w0rQIpv5FbZEwJI/dKxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788022191; c=relaxed/simple;
	bh=gPlqbRhQE7ty70KtWsc7oE5oEYx+ZNOSm/Bh+jDmG84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/85ScfnAajrIg3jNr3BpKgAyGtZbxekLgwOzAbinf/1dFOK/Rql7MSkgqejiQDRHfYXVQMlj86eaA6opLha+hDROorRHZafcH6B8tW8QBITLwpuDhyXBr9/FJoNozOIDy1Z7qgHObqK5XGysZsfZF1MnFq/AE0ARC2d2wbKRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=wKrGcTVY; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=wKrGcTVY; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="wKrGcTVY";
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="wKrGcTVY"
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id CD5C5A0191;
	Sat, 29 Aug 2026 18:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1788022186; bh=gPlqbRhQE7ty70KtWsc7oE5oEYx+ZNOSm/Bh+jDmG84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wKrGcTVYXuClBJI9HHYI/nFppuBr7lzXYEhYipws0czvBCrmRr/ZPv5gzlId6Ib2x
	 Kr9fK7dhoA+bZf8FVJF7fAxbBWuyquYTWrjdHa0WEdEnI4WVszls6wsaQjrG4QJuZc
	 FaoiVe+YWf33aF3E6MbYzjUeCFw3y+vdGn7fKosVXEXN3mL8kb2BN88LqLskEzm3rb
	 iuqPIWGffEAaR5ECRtn54uKqj+0QF8gXa8YDOeJMeXgC4UP+OGc9LIkDP9SKo75Fng
	 GUWBp46NBulzP8tfr+wpebbRntmJ4c/wzVcZvMkWHQEFHMxKuBymOJS7Jl6eK+0rzz
	 VW08mhs/4y14Q==
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ah3xixdBzOKX; Sat, 29 Aug 2026 18:49:46 +0200 (CEST)
Received: from end (aamiens-653-1-40-48.w83-192.abo.wanadoo.fr [83.192.199.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 2FC34A03B7;
	Sat, 29 Aug 2026 18:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1788022186; bh=gPlqbRhQE7ty70KtWsc7oE5oEYx+ZNOSm/Bh+jDmG84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wKrGcTVYXuClBJI9HHYI/nFppuBr7lzXYEhYipws0czvBCrmRr/ZPv5gzlId6Ib2x
	 Kr9fK7dhoA+bZf8FVJF7fAxbBWuyquYTWrjdHa0WEdEnI4WVszls6wsaQjrG4QJuZc
	 FaoiVe+YWf33aF3E6MbYzjUeCFw3y+vdGn7fKosVXEXN3mL8kb2BN88LqLskEzm3rb
	 iuqPIWGffEAaR5ECRtn54uKqj+0QF8gXa8YDOeJMeXgC4UP+OGc9LIkDP9SKo75Fng
	 GUWBp46NBulzP8tfr+wpebbRntmJ4c/wzVcZvMkWHQEFHMxKuBymOJS7Jl6eK+0rzz
	 VW08mhs/4y14Q==
Received: from samy by end with local (Exim 4.100-RC3)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1x0MFV-0000000BI8Z-2ah4;
	Sat, 29 Aug 2026 18:49:45 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: gregkh@linuxfoundation.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org,
	kirk@reisers.ca,
	w.d.hubbs@gmail.com,
	co+e5693071d903b832@bugs.sh,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Fix NULL pointer dereference on VT switch + selection
Date: Sat, 29 Aug 2026 18:49:45 +0200
Message-ID: <20260829164945.2691317-3-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829164945.2691317-1-samuel.thibault@ens-lyon.org>
References: <20260829164945.2691317-1-samuel.thibault@ens-lyon.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When selecting/pasting very quickly after VT switch, the tty is not set
yet, leading to a NULL dereference. We can just abort the operation.

Reported-by: co+e5693071d903b832@bugs.sh
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: stable@vger.kernel.org
---
 drivers/accessibility/speakup/selection.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accessibility/speakup/selection.c b/drivers/accessibility/speakup/selection.c
index 1713ce4e0ba5..a04a7e8c307b 100644
--- a/drivers/accessibility/speakup/selection.c
+++ b/drivers/accessibility/speakup/selection.c
@@ -61,6 +61,9 @@ static struct speakup_selection_work speakup_sel_work = {
 
 int speakup_set_selection(struct tty_struct *tty)
 {
+	if (!tty)
+		return -ENODEV;
+
 	/* we get kref here first in order to avoid a subtle race when
 	 * cancelling selection work. getting kref first establishes the
 	 * invariant that if speakup_sel_work.tty is not NULL when
@@ -120,6 +123,9 @@ static struct speakup_selection_work speakup_paste_work = {
 
 int speakup_paste_selection(struct tty_struct *tty)
 {
+	if (!tty)
+		return -ENODEV;
+
 	tty_kref_get(tty);
 	if (cmpxchg(&speakup_paste_work.tty, NULL, tty)) {
 		tty_kref_put(tty);
-- 
2.47.3

