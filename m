Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365100;
	b=VDTVQx3s6ZHKisJjvqtiWSYa34IAkBXPowf2TcmlzA1cMI4xfhPdTFrPUp6wW3TDqRsR
	 mOahNpu3wrj+k9iEdgSYoNMFfWny+T7ozIHYaGziwnLbiOL0shRKYgypURUevtUMMZdN2
	 cqz0Y8D43VqpaXj1ErnYCSfq8xiRDQoIXi0AZb2hKQSC8cfb23xuqQZ9r/mfuYvWiIfJj
	 mNjMu5KO1ij1kG4Ev/ciEWo8zZOk8GHwns3X0IFyLN5HU077s3dZuRkVDOCadLn7sltwN
	 ZzeQ+ncGEIJKeeHxU2DUD/Onn1bh1/fNNnuE28Y+d3iYDAK/lfQx5ZBF/v0PJUDdTWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eukGeU9lyVHWvn6sPiq1fKfuFnjHqVrv7SCzRTZJATg=;
	b=O//XNkwnEfCmSrglmc+tTtCzxX00PnhDqzRCk41zCsFWGOqL9TgXYmzVdl8Zq3TiwKh/
	 uH7xondf5pQQ75eemU/BIAIZE1L0cWc8tq+fBPn/Hkna+ea+GQsJvQpxo4OwcbPp/buxx
	 otrPz7wTOqm3L7MtRz5BAgBigfmwz51EI0NcwUJ+bD987HjtzLDphPF1C5fYZx+C82H5z
	 BL5qY5WT2mFE+O7KRFTcqJObNN/p4NCmCB/aGZGMNiVZ4R9I/6qo2y34kpeAKUP3OT5AE
	 6e7aFxYscc9Ly9L7pLjXss5MRpG/y/PJ5KDep7bBMZgWAplDA2dkrL0SZtA3qr0dqKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="bWCXpf/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F92606A325;
	Fri, 30 Oct 2026 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bWCXpf/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0A81F0093A;
	Fri, 30 Oct 2026 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793365100;
	bh=eukGeU9lyVHWvn6sPiq1fKfuFnjHqVrv7SCzRTZJATg=;
	h=From:To:Cc:Subject:Date;
	b=bWCXpf/XraXSvOtQDPUcB52qxGVGVopumnCmR+Gtd3NxVnsx06FlSA31TnEtdCazo
	 8c7QlngE7k4yvO9P5YfG3gDyZohNwVDfnx94owHrhGYXgCpcc3Gya8/HNVCBunkp9P
	 WzS1XkqyB9lSXAAgNcghJ60lBiVvOP4dlAj4uZNw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.60
Date: Fri, 30 Oct 2026 13:58:03 +0100
Message-ID: <2026103003-clause-bagpipe-08a2@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.60 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                |    2 
 block/blk-zoned.c                                                       |   37 
 block/blk.h                                                             |    4 
 block/genhd.c                                                           |    2 
 crypto/asymmetric_keys/restrict.c                                       |    8 
 drivers/acpi/acpi_platform.c                                            |   79 +-
 drivers/acpi/scan.c                                                     |    4 
 drivers/acpi/tiny-power-button.c                                        |   25 
 drivers/net/ethernet/intel/ice/ice_base.c                               |   33 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                            |    1 
 drivers/net/ethernet/intel/ice/ice_txrx.c                               |    4 
 drivers/net/ethernet/intel/ice/ice_xsk.c                                |    3 
 fs/coredump.c                                                           |   16 
 fs/tracefs/event_inode.c                                                |    6 
 include/linux/io_uring_types.h                                          |    5 
 include/linux/ioport.h                                                  |   20 
 include/linux/key-type.h                                                |    1 
 include/linux/key.h                                                     |    5 
 include/linux/sched.h                                                   |    2 
 include/linux/sched/signal.h                                            |   27 
 include/net/ax25.h                                                      |    6 
 include/net/codel_impl.h                                                |    1 
 include/net/gso.h                                                       |    8 
 include/net/netrom.h                                                    |   18 
 include/net/rose.h                                                      |    5 
 io_uring/cancel.c                                                       |   29 
 io_uring/cancel.h                                                       |    2 
 io_uring/fdinfo.c                                                       |   14 
 io_uring/futex.c                                                        |   32 
 io_uring/io-wq.c                                                        |  126 ++-
 io_uring/io_uring.c                                                     |  231 +++++-
 io_uring/io_uring.h                                                     |   44 +
 io_uring/kbuf.c                                                         |    2 
 io_uring/napi.c                                                         |    4 
 io_uring/net.c                                                          |   26 
 io_uring/openclose.c                                                    |   11 
 io_uring/poll.c                                                         |   38 
 io_uring/register.c                                                     |   20 
 io_uring/rw.c                                                           |   18 
 io_uring/sqpoll.c                                                       |    7 
 io_uring/timeout.c                                                      |   91 +-
 io_uring/uring_cmd.c                                                    |    2 
 io_uring/waitid.c                                                       |   19 
 io_uring/zcrx.c                                                         |    2 
 kernel/exit.c                                                           |    5 
 kernel/fork.c                                                           |    9 
 kernel/pid_namespace.c                                                  |    3 
 kernel/ptrace.c                                                         |    6 
 kernel/resource.c                                                       |    4 
 kernel/signal.c                                                         |    4 
 kernel/trace/ftrace.c                                                   |    4 
 kernel/trace/trace.c                                                    |   21 
 kernel/trace/trace_events_filter.c                                      |    6 
 kernel/trace/trace_events_hist.c                                        |   33 
 kernel/trace/trace_events_synth.c                                       |   10 
 kernel/trace/trace_synth.h                                              |    1 
 mm/damon/core.c                                                         |   22 
 mm/damon/sysfs.c                                                        |   19 
 net/ax25/af_ax25.c                                                      |   81 +-
 net/ax25/ax25_ds_in.c                                                   |    2 
 net/ax25/ax25_in.c                                                      |   55 +
 net/ax25/ax25_out.c                                                     |  121 ++-
 net/ax25/ax25_std_in.c                                                  |    8 
 net/ax25/ax25_subr.c                                                    |   44 -
 net/bluetooth/l2cap_core.c                                              |    7 
 net/bluetooth/l2cap_sock.c                                              |    2 
 net/core/gso.c                                                          |    1 
 net/ipv4/af_inet.c                                                      |    3 
 net/ipv6/ip6_offload.c                                                  |    4 
 net/netrom/af_netrom.c                                                  |   33 
 net/netrom/nr_in.c                                                      |   26 
 net/netrom/nr_route.c                                                   |  383 +++++-----
 net/rose/af_rose.c                                                      |    5 
 net/rose/rose_in.c                                                      |   31 
 net/rose/rose_link.c                                                    |   42 +
 net/rose/rose_loopback.c                                                |    2 
 net/rose/rose_out.c                                                     |    1 
 net/rose/rose_route.c                                                   |  119 ++-
 security/keys/key.c                                                     |   13 
 security/keys/keyctl.c                                                  |   15 
 security/keys/keyring.c                                                 |  152 ++-
 security/keys/process_keys.c                                            |    5 
 security/keys/trusted-keys/trusted_tpm1.c                               |    4 
 security/keys/trusted-keys/trusted_tpm2.c                               |    2 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc |   24 
 85 files changed, 1760 insertions(+), 612 deletions(-)

Aaron Ahmed (1):
      ftrace: Initialize modname and offset in print_rec()

Adrian Martinez (1):
      KEYS: Fix key_reject_and_link() race with keyring restriction

Ashutosh Desai (1):
      ax25: fix OOB read after address header strip in ax25_rcv()

Austin Schuh (1):
      io_uring/wait: wake real-time waiters from hard interrupt context

Bernard Pidoux (20):
      rose: clear stale N(R)/N(S) before (re)transmitting a data frame
      netrom: bound fragment reassembly in nr_queue_rx_frame()
      ax25: check frame length in ax25_decode() and ax25_rx_iframe()
      netrom: use a single lock for the node and neighbour lists
      netrom: look up and update routes in one critical section
      netrom: clear nr_neigh->ax25 under the routing lock in nr_link_failed()
      netrom: fix nr_node leak when nr_del_node() removes the last route
      rose: clear through routes when a neighbour is removed from the tables
      rose: restart the link of a neighbour created over a live AX.25 connection
      ax25: serialise the transmission of I frames on a connection
      rose: process received frames and send with the socket locked
      ax25: don't create two connections for the same link in ax25_send_frame()
      ax25: read the connection's ax25_dev only once when walking ax25_list
      ax25: wait for ax25_send_frame() before detaching the connections of a device
      ax25: don't accept frames on a device that is going down
      ax25: send a private copy of each I frame
      rose: clear the circuits of a neighbour that restarts the link
      ax25: send unacknowledged I frames again when a link is re-established
      rose: bring up the link of the preferred route passed over by a connect request
      ax25: don't free an incoming SABM skb left on the listener's queue

Cen Zhang (4):
      keys: Avoid the owner account dereference in named keyring lookup
      keys: Check the authorization payload in process keyring searches
      keys: Protect the type name while describing a key
      keys: Protect the read method check against type removal

Christian Brauner (9):
      io-wq: order the exit bit against worker creation task work
      coredump: hold RCU while releasing parked threads
      signal: don't retarget shared signals in a dying thread group
      signal: only SIGKILL and the freezers interrupt a coredumping task
      ptrace: refuse to change the signal mask of a user worker
      fork: release the files of a failed fork after sched_cancel_fork()
      exit: hang up the tty before closing the files
      signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
      pid_namespace: prevent TIF_NOTIFY_SIGNAL from interrupting the reaper

Damien Le Moal (1):
      block: avoid potential deadlock on zone revalidation failure

David Carlier (2):
      tracing: Hold trace_types_lock when updating modules in persistent instances
      tracing: Hold trace_types_lock when resetting last boot data from readers

Donggeun Yoo (3):
      tracing: Save the event file instead of the compatible histogram
      tracing: Unregister field variable histograms when the command fails
      tracing: Fix 64-bit and signed histogram fields on 32-bit kernels

Greg Kroah-Hartman (2):
      netrom: require full NET/ROM headers in nr_route_frame()
      Linux 6.18.60

Ilpo Järvinen (1):
      resource: Add __resource_contains_unbound() for internal contains checks

Jens Axboe (6):
      io_uring/timeout: don't put a sequence target behind the last flush
      io_uring/timeout: don't flush with the sequence behind the last flush
      io_uring/timeout: don't lose a cancel as io-wq arms a timeout
      io_uring/poll: don't loop on HUP with multiple references
      io_uring: end the drain when the drain request completes
      io_uring: keep the drain active when a deferred drain request is started

Jonas Köppeler (1):
      net_sched: codel: fix stale state for empty flows in fq_codel

Josef Bacik (37):
      io_uring/waitid: own the request before clearing ->head
      io_uring/cmd: don't leave list poison in ->hash_node
      io_uring/wait: don't spin on a stuck overflow list
      io_uring/io-wq: don't lose the signal that ends work
      io_uring/io-wq: don't hide a link from cancellations
      io_uring: don't flood a cancelling task with task_work
      io_uring/io-wq: don't go to sleep on pending work
      io_uring/io-wq: don't strand work when a worker exits
      io_uring/io-wq: don't exit with a creation pending
      io_uring/io-wq: let cancel find picked up hashed work
      io_uring/poll: don't lose a cancel as io-wq arms poll
      io_uring: don't lose a cancel as io-wq parks a request
      io_uring/cancel: don't forget that the work was running
      io_uring/cancel: recognize "no timeout" on 32-bit
      io_uring/cancel: let CANCEL_ALL find parked requests
      io_uring: wake ring pollers for local task_work
      io_uring/wait: look at all CQ waiters on wake up
      io_uring/poll: drop stale double poll entry on rearm
      io_uring/futex: allocate private hash before waiting
      io_uring: drop the CQE cache if a refill fails
      io_uring/register: don't wrap 32b CQEs when resizing
      io_uring/register: handle index wrap when resizing
      io_uring/fdinfo: fix CQE dump of CQE32 rings
      io_uring/timeout: don't skip over reached sequences
      io_uring/timeout: keep repeat count on multishot update
      io_uring/wait: no early -ETIME if min_wait finds work
      io_uring/napi: make stale entries time out after 60s
      io_uring/napi: don't busy poll past an expired timeout
      io_uring/zcrx: fix buffer offsets in areas above 4GB
      io_uring/kbuf: handle index wrap in last buffer check
      io_uring/sqpoll: let the thread sleep on disabled rings
      io_uring/openclose: keep the lock in io_pipe_fixed()
      io_uring: don't pass restart error codes to userspace
      io_uring/net: don't retry recv on uncommitted buffers
      io_uring/timeout: no ABS update of multishot timeouts
      io_uring/timeout: don't end a linked timeout with 1
      io_uring: look up the file before queueing to io-wq

Joseph Qi (1):
      eventfs: fix SRCU read lock leak in eventfs_iterate()

Juanlu Herrero (1):
      io_uring/poll: avoid retry wakeup loss when dropping ownership

Junjie Cao (1):
      netrom: fix reference count leak in nr_rt_device_down

Junyeong Lee (1):
      io_uring/waitid: prevent cancel reference wrap

Kyle Zeng (2):
      tracing: Reject incomplete event filter expressions
      keys: make keyring indexes independent of kernel addresses

Larysa Zaremba (2):
      ice: fix rxq info registering in mbuf packets
      ice: change XDP RxQ frag_size from DMA write length to xdp.frame_sz

Lee Jones (1):
      tracing/histograms: Verify event_call identity when updating synth_event refcount

Mashiro Chen (2):
      net: netrom: validate source address in nr_find_socket()
      net: ax25: fix integer overflow in ax25_rx_fragment()

Pauli Virtanen (1):
      Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn

Rafael J. Wysocki (4):
      ACPI: scan: Register platform devices for fixed event buttons
      ACPI: scan: Avoid registering platform devices with resource overlaps
      ACPI: scan: Do not combine resources that overlap completely
      ACPI: tiny-power-button: Convert the driver to a platform one

SJ Park (1):
      mm/damon/core: error damos_commit_quota_goal() for zero target_value

Srish Srinivasan (1):
      keys/trusted_keys: return immediately after TPM unseal failure

Stanislav Fort (1):
      netrom: linearize and validate lengths in nr_rx_frame()

Stefano Garzarella (1):
      KEYS: trusted: Fix blob allocation size in tpm2_key_decode()

Tamaki Yanagawa (1):
      io_uring/net: keep recv buffer select length within MAX_RW_COUNT

Weiming Shi (1):
      asymmetric_keys: reject trust keys without IDs

Zihan Xi (1):
      net: gso: limit recursive IP-in-IP segmentation

