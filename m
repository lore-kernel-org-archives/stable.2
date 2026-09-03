Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE44BB80B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445951; cv=none; b=Mqe/9z6eWTwo07onSORiP3rORoShvE/u6pv8t0DwIaCC5oXYhe8dwsI4aqhz0baQc46F8jqHv5dX4bSgmFu7FRKaKXis2Y6ODmfZRwAFDLAcoN6xRJU+WZMnpkUcKxkRDUvaQ88+w+VRg4gqgWIdifo07hDybzFOEGw8hCCKjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445951; c=relaxed/simple;
	bh=8MwZlssephbhNg6oj/X3kuIj3QUgzxvE3iJm+qYljKU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=plNjT3qAlhW+n07r/0uzvrrFqMnxQ6dPzaPMx5O89bjsPw0HSRBFRUWRcMjzeXESVWII5Cu6IbrbEq3wyGLI2RyfprBDDa9ZEE5JIvDJ+T+oCmNL4wJF4t3Gbj7Ruuh618sogNpVZnXT3dvX8mENi85Ui1QPwWePko4zzXbtq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZurusvOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZurusvOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12EB1F000E9;
	Thu,  3 Sep 2026 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445940;
	bh=4fC59/EtalFbbjxoUCUvaSkYutTG/65t0sSqaktXK3s=;
	h=Subject:To:Cc:From:Date;
	b=ZurusvOahPPeov11OMrJ+Jy4AdxckZWHXyETuXpWzEg8hrbKDmO0foqOrRRAC1MKi
	 uflgYnpdGFhrWvYsJruOYcp0WvpQqPkafT8Z+nLd8Zh2m5XKE79Z5FYsSHvnpQHBQ+
	 ps6I8+lqSy/Mt1mXE8zAxGBG3mq01XsOmb83e650=
Subject: FAILED: patch "[PATCH] staging: media: tegra-video: vi: fix probe failure on skipped" failed to apply to 5.10-stable tree
To: alvinhuang0603@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:12:33 +0200
Message-ID: <2026090333-bankroll-pueblo-bde6@gregkh>
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
git cherry-pick -x ae15adeed9f7ec54989175fe3c9e0815186821bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090333-bankroll-pueblo-bde6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ae15adeed9f7ec54989175fe3c9e0815186821bc Mon Sep 17 00:00:00 2001
From: Hao-Qun Huang <alvinhuang0603@gmail.com>
Date: Tue, 7 Jul 2026 23:24:25 +0800
Subject: [PATCH] staging: media: tegra-video: vi: fix probe failure on skipped
 last port

tegra_vi_channels_alloc() iterates over port nodes and skips those
whose reg property cannot be read or whose remote endpoint fails
v4l2_fwnode_endpoint_parse(), leaving the negative result of the
failed call in ret. If that happens on the last port node, the loop
ends with ret still negative and tegra_vi_init() fails the whole VI
probe.

The same defective port earlier in the ports node is skipped silently,
so probing succeeds or fails depending on the order of the port nodes.
The CSI equivalent, tegra_csi_channels_alloc(), returns 0
unconditionally after its loop and does not have this problem.

Use a separate variable for the per-port checks so that only fatal
errors end up in ret.

Fixes: 1ebaeb09830f ("media: tegra-video: Add support for external sensor capture")
Fixes: 2ac4035a78c9 ("media: tegra-video: Add support for x8 captures with gang ports")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index ce09949178f6..01622013c109 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1257,6 +1257,7 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 	struct device_node *parent;
 	struct v4l2_fwnode_endpoint v4l2_ep = { .bus_type = 0 };
 	unsigned int lanes;
+	int err;
 	int ret = 0;
 
 	ports = of_get_child_by_name(node, "ports");
@@ -1267,8 +1268,8 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 		if (!of_node_name_eq(port, "port"))
 			continue;
 
-		ret = of_property_read_u32(port, "reg", &port_num);
-		if (ret < 0)
+		err = of_property_read_u32(port, "reg", &port_num);
+		if (err < 0)
 			continue;
 
 		if (port_num > vi->soc->vi_max_channels) {
@@ -1289,10 +1290,10 @@ static int tegra_vi_channels_alloc(struct tegra_vi *vi)
 
 		ep = of_graph_get_endpoint_by_regs(parent, 0, 0);
 		of_node_put(parent);
-		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep),
+		err = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep),
 						 &v4l2_ep);
 		of_node_put(ep);
-		if (ret)
+		if (err)
 			continue;
 
 		lanes = v4l2_ep.bus.mipi_csi2.num_data_lanes;

